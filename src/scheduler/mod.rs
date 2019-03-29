use crate::console;
use crate::machine_info::{*};
use crate::utils::rbtree::rbtree;
use core::fmt::Write;
use core::ptr::null;
use crate::mem::heap::{*};

extern "C" {
    static mut GLOBAL_CTX: [u32; 32];
}

pub static mut sched:scheduler = scheduler::new();

#[derive(Clone, Debug)]
pub struct PCB {
    context            : [u32; 32],
    pc                 :  u32,
    vruntime           :  u32,
    QM                 :  u32,
    pid                :  u32,
    stack_size         :  u32,
    stack_pointer      :  u32,
}

pub struct scheduler {
    current: *mut PCB,
    schedule: *mut rbtree<u32, *mut PCB>,
    next_pid: u32,
}

impl scheduler {
    pub const fn new() -> Self{
        scheduler{
            current: core::ptr::null::<PCB>() as *mut PCB,
            schedule: core::ptr::null::<rbtree<u32, *mut PCB>>() as *mut rbtree<u32, *mut PCB>,
            next_pid: 0,
        }
    }

    pub fn init(&mut self){
        scheduler::reset_timers();
        self.schedule = kmalloc(core::mem::size_of::<rbtree<u32, *mut PCB>>() as u32)
                   as *mut rbtree<u32, *mut PCB>;
        unsafe{
            *(self.schedule) = rbtree::new();
        }
    }

    pub unsafe fn update_schedule(&mut self, mut mepc: u32)-> u32 {
        if self.current.is_null() { 
            scheduler::reset_timers();
            println!("CURRENT IS STILL NULL");
            return mepc; 
        }
        (*self.current).context = GLOBAL_CTX;
        (*self.current).pc      = mepc;
        (*self.current).vruntime += (*self.current).QM;
        (*self.schedule).insert((*self.current).vruntime, self.current);
        if let Some((time, pcb)) = (*self.schedule).first(){
            self.current = *pcb;
            (*self.schedule).delete(*time);
        }else{
            println!("EMPTY SCHEDULER TREE ERROR BAD TIME");
        }
        GLOBAL_CTX = (*self.current).context;
        mepc = (*self.current).pc;
        scheduler::reset_timers();
        return mepc;
    }

    pub unsafe fn new_process(&mut self, stack_size: u32, ip: u32, QM: u32) -> u32 {
        let pcb: *mut PCB = kmalloc(core::mem::size_of::<PCB>() as u32) as *mut PCB;
        println!("Size of PCB struct {}", core::mem::size_of::<PCB>());
        let stack: *mut u32 = kmalloc(stack_size);
//        (*pcb).context[1] = ra as u32; //function pointer to return address
        (*pcb).context[2] = stack as u32 + stack_size;
        (*pcb).stack_pointer = stack as u32;
        (*pcb).pid           = self.next_pid;
        (*pcb).vruntime      = 0;
        (*pcb).pc            = ip;

        println!("PUTTING INIT ON SCHEDULE {:p}", pcb);
        (*self.schedule).insert((*pcb).vruntime, pcb);
        if self.current.is_null() {
            println!("SETTING INIT TO CURRENT");
            self.current = pcb;
        }
        self.next_pid += 1;
        return (*pcb).pid;
    }

    fn reset_timers() {

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
}
