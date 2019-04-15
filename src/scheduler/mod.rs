use crate::console;
use crate::machine_info::{*};
use crate::utils::rbtree::{ rbtree, rbtree_node };
use core::fmt::Write;
use core::ptr::null;
use crate::mem::heap::{*};
use crate::console::{print_c_str};

extern "C" {
    static mut GLOBAL_CTX: [u32; 32];
}

pub static mut sched:scheduler = scheduler::new();

#[derive(Clone, Debug)]
pub struct PCB {
    pub context            : [u32; 32],
    pub pc                 :  u32,
    pub vruntime           :  u32,
    pub QM                 :  u32,
    pub pid                :  i32,
    pub stack_size         :  u32,
    pub stack_pointer      :  u32,
    pub name               :  *const char,
    pub kill               :  bool,
    pub waitpid            :  i32,
    pub sleep              :  i16,
}

pub struct scheduler {
    pub current: *mut PCB,
    pub schedule: *mut rbtree<u32, *mut PCB>,
    pub next_pid: i32,
}

impl scheduler {
    pub const fn new() -> Self{
        scheduler{
            current: core::ptr::null::<PCB>() as *mut PCB,
            schedule: core::ptr::null::<rbtree<u32, *mut PCB>>() as *mut rbtree<u32, *mut PCB>,
            next_pid: 0,
        }
    }

    pub fn init(&mut self) {
        reset_timers();
        self.schedule = kmalloc(core::mem::size_of::<rbtree<u32, *mut PCB>>() as u32)
                   as *mut rbtree<u32, *mut PCB>;
        unsafe{
            *(self.schedule) = rbtree::new();
        }
    }

    pub unsafe fn update_schedule(&mut self, mut mepc: u32)-> u32 {
        if self.current.is_null() { 
            // println!("CURRENT WAS NULL -- looking for process");
            let old_mepc = mepc;
            mepc = self.schedule_next(mepc);
            if old_mepc != mepc {
                println!("found a process to run: {:X}", mepc);
            }
            reset_timers();
            return mepc; 
        }
        (*self.current).context   = GLOBAL_CTX;
        (*self.current).vruntime += (*self.current).QM;
        (*self.current).pc        = mepc;

        self.add_to_tree((*self.current).vruntime, self.current);

        (self.current) = core::ptr::null::<PCB>() as *mut PCB;

        mepc = self.schedule_next(mepc);
        reset_timers();

        return mepc;
    }

    pub unsafe fn schedule_next(&mut self, mut mepc: u32) -> u32 {
        let waiting = kmalloc(((*self.schedule).len as u32) * core::mem::size_of::<*mut PCB>() as u32)
            as *mut *mut PCB;

        let mut n_waiting = 0;

        let all_pcbs = self.collect_all_procs();
        loop {
            if let Some((time, pcb)) = (*self.schedule).first() {
                (*self.schedule).delete(*time);
                if !(*(*pcb)).kill {
                    if (*(*pcb)).waitpid != -1 {
                        if scheduler::array_of_pcbs_has_pid(all_pcbs, (*(*pcb)).waitpid) {
                            *waiting.offset(n_waiting) = *pcb;
                            n_waiting += 1;
                        } else {
                            self.current = *pcb;
                            (*self.current).waitpid = -1;
                            break;
                        }
                    } else if (*(*pcb)).sleep <= 0 {
                        self.current = *pcb;
                        break;
                    } else {
                        *waiting.offset(n_waiting) = *pcb;
                        n_waiting += 1;
                    }
                }

                let sp = (*(*pcb)).stack_pointer as *mut u32;
                if sp.is_null() {
                    println!("sp is NULL????");
                }
                kfree(sp);

            } else {
                if !all_pcbs.is_null() {
                    kfree(all_pcbs as *mut u32);
                }
                if !waiting.is_null() {
                    kfree(waiting as *mut u32);
                }
            }
            return mepc;
        }

        for i in 0..n_waiting {
            self.add_to_tree((*(*waiting.offset(i))).vruntime, *waiting.offset(i));
        }
        let mut ptr = all_pcbs;
        while !(*ptr).is_null() {
            (*(*ptr)).sleep -= 1;
            ptr = ptr.offset(1)
        }

        GLOBAL_CTX = (*self.current).context;

        if !all_pcbs.is_null() {
            kfree(all_pcbs as *mut u32);
        }
        if !waiting.is_null() {
            kfree(waiting as *mut u32);
        }

        return (*self.current).pc;
    }

    pub unsafe fn new_process(&mut self, stack_size: u32, ip: u32, QM: u32, data : *mut u32, mut data_len : u32, name : *const char) -> i32 {
        let pcb: *mut PCB = kmalloc(core::mem::size_of::<PCB>() as u32) as *mut PCB;
        let stack: *mut u32 = kmalloc(stack_size);
        
        if stack.is_null() {
            println!("could not allocate process stack!");
        }

        let mut data_dst = core::ptr::null::<u32>() as *mut u32;

        if data.is_null() {
            data_len = 0;
            data_dst = stack.offset(stack_size as isize);
        } else {
            data_dst = stack.offset((stack_size - data_len) as isize);
            core::ptr::copy_nonoverlapping(data, data_dst, data_len as usize);
        }

//        (*pcb).context[1] = ra as u32; //function pointer to return address
        (*pcb).context[10] = data_dst as u32;
        (*pcb).context[11] = data_len;
        (*pcb).context[2] = stack as u32 + stack_size;
        (*pcb).stack_pointer = stack as u32;
        (*pcb).pid           = self.next_pid;
        (*pcb).vruntime      = ((*self.schedule).len as u32);
        (*pcb).pc            = ip;
        (*pcb).kill          = false;
        (*pcb).QM            = QM;
        (*pcb).waitpid       = -1;
        (*pcb).sleep         = 0;

        self.add_to_tree((*pcb).vruntime, pcb);
        self.next_pid += 1;
        
        println!("new_process(): new pid = {}", (*pcb).pid);

        return (*pcb).pid;
    }

    unsafe fn add_to_tree(&mut self, mut key : u32, val : *mut PCB) {
        loop {
            if let None = (*self.schedule).lookup(key) {
                (*self.schedule).insert(key, val);
                break;
            }

            key += 1;
        }
    }

    unsafe fn _tree_get_node_with_pid(node : *mut rbtree_node<u32, *mut PCB>, pid : i32) -> *mut rbtree_node<u32, *mut PCB> {
        if (*(*node).val).pid == pid { return node; }

        if !(*node).children[0].is_null() {
            let l = scheduler::_tree_get_node_with_pid((*node).children[0], pid);
            if !l.is_null() { return l; }
        }
        
        if !(*node).children[1].is_null() {
            let r = scheduler::_tree_get_node_with_pid((*node).children[1], pid);
            if !r.is_null() { return r; }
        }

        return core::ptr::null::<rbtree_node<u32, *mut PCB>>() as *mut rbtree_node<u32, *mut PCB>;
    }

    pub unsafe fn tree_has_pid(&mut self, pid : i32) -> bool {
        return scheduler::_tree_get_node_with_pid((*self.schedule).root, pid).is_null();
    }

    pub unsafe fn get_pcb(&mut self, pid : i32) -> *mut PCB {
        if (*self.current).pid == pid {
            return self.current;
        }

        let node = scheduler::_tree_get_node_with_pid((*self.schedule).root, pid);

        if !node.is_null() {
            return (*node).val;
        }

        return core::ptr::null::<PCB>() as *mut PCB;
    }

    unsafe fn _collect_all_procs(node : *mut rbtree_node<u32, *mut PCB>, array : *mut *mut PCB, idx : &mut u32) {
        *array.offset(*idx as isize) = (*node).val;

        *idx += 1;

        if !(*node).children[0].is_null() {
            scheduler::_collect_all_procs((*node).children[0], array, idx);
        }
        if !(*node).children[1].is_null() {
            scheduler::_collect_all_procs((*node).children[1], array, idx);
        }
    }

    pub unsafe fn collect_all_procs(&mut self) -> *mut *mut PCB {
        let mut n = (*self.schedule).len + 1;
        if !self.current.is_null() {
            n += 1;
        }

        let array = kmalloc(n as u32 * core::mem::size_of::<*mut PCB>() as u32) as *mut *mut PCB;

        let mut idx = 0;
        if !self.current.is_null() {
            *array.offset(0) = self.current;
            idx += 1;
        }

        scheduler::_collect_all_procs((*self.schedule).root, array, &mut idx);

        *array.offset(idx as isize) = core::ptr::null::<PCB>() as *mut PCB;

        return array;
    }

    unsafe fn array_of_pcbs_has_pid(array : *mut *mut PCB, pid : i32) -> bool {
        let mut ptr = array;

        while !(*ptr).is_null() {
            if (*(*ptr)).pid == pid {
                return true;
            }
            ptr = ptr.offset(1);
        }

        return false;
    }
}

pub fn reset_timers() {

    let mtimelo        : &mut u32 = get_clint_register(ClintRegister :: MTIMELO);
    let mtimehi        : &mut u32 = get_clint_register(ClintRegister :: MTIMEHI);
    let mtimecmplo     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPLO);
    let mtimecmphi     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPHI);

    let cur_mtimelo    : u32      = *mtimelo;
    let cur_mtimehi    : u32      = *mtimehi;

    let interval = (FREQ as u64) / 1;

    let mtime64        : u64 = ((cur_mtimehi as u64) << 32) + (cur_mtimelo as u64);
    let mtimecmp64     : u64 = mtime64 + interval;
    let new_mtimecmphi : u32 = (mtimecmp64 >> 32) as u32;
    let new_mtimecmplo : u32 = (mtimecmp64 & 0x00000000FFFFFFFF) as u32;

    *mtimecmplo = new_mtimecmplo;
    *mtimecmphi = new_mtimecmphi;
}
