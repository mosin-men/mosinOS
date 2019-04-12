/*  Define interface and functions to do both User mode 
 *  and System level ecalls                            */

use crate::console as console;
use crate::machine_info::{*};
use crate::scheduler::{*};
use crate::mem::heap::{*};
use core::fmt::Write;

extern "C" {
    pub fn _UMODE_SWITCH();
    pub fn _MMODE_SWITCH();
}


pub const EXIT:     u32 = 1;
pub const WRITE:    u32 = 2;
pub const READ:     u32 = 3;
pub const ALLOC:    u32 = 4;
pub const FREE:     u32 = 5;
pub const BARRIER:  u32 = 6;
pub const SPAWN:    u32 = 7;
pub const WAITPID:  u32 = 8;
pub const KILL:     u32 = 9;
pub const NPROC:    u32 = 10;
pub const PROCS:    u32 = 11;
pub const SLEEP:    u32 = 12;

pub const UMODE:    u32 = 0;
pub const MMODE:    u32 = 3;

pub struct process_info {
    pub pid      : i32,
    pub vruntime : u32,
    pub name     : *const char,
    pub waitpid  : i32,
    pub sleep    : i16
}

extern "C" {
    fn ecall_wrapper(code : u32, arg0 : u32, arg1 : u32, arg2 : u32, arg3 : u32, arg4 : u32, arg5 : u32) -> u32;
}

pub unsafe fn syscall(code : u32, arg0 : u32, arg1 : u32, arg2 : u32, arg3 : u32, arg4 : u32, arg5 : u32) -> u32 {
    let result = ecall_wrapper(code, arg0, arg1, arg2, arg3, arg4, arg5);

    match code {
        EXIT            => loop { asm!("wfi") },
        WAITPID | SLEEP => asm!("wfi"),
        _               => {}
    };

    return result
}

pub fn do_msyscall (code: u32) {
    match code {
        UMODE => unsafe {_UMODE_SWITCH();},
        MMODE => unsafe {_MMODE_SWITCH();},
        _     => println!("Unknown Machine Mode ECALL CODE {}", code),
    }
}


pub unsafe fn do_syscall (code: u32, arg0 : u32, arg1 : u32, arg2 : u32, arg3 : u32, arg4 : u32, arg5 : u32) -> u32 {
    let mut result = 0;
    match code {
        EXIT    => result = handle_exit(),
        WRITE   => println!("SYSCALL WRITE"),
        READ    => println!("SYSCALL READ"),
        ALLOC   => result = handle_alloc(arg0),
        FREE    => result = handle_free(arg0),
        BARRIER => println!("SYSCALL BARRIER"),
        SPAWN   => result = handle_spawn(arg0, arg1, arg2, arg3, arg4, arg5),
        WAITPID => result = handle_waitpid(arg0),
        KILL    => result = handle_kill(arg0),
        NPROC   => result = handle_nproc(),
        PROCS   => result = handle_procs(arg0),
        SLEEP   => result = handle_sleep(arg0),
        _       => println!("Unknown User Mode ECALL CODE"),
    };
    return result;
}

unsafe fn handle_exit() -> u32 {
    if sched.current.is_null() {
        return 1;
    }

    (*sched.current).kill = true;
    return 0;
}

unsafe fn handle_alloc(n_bytes : u32) -> u32 {
    return kmalloc(n_bytes) as u32;
}
unsafe fn handle_free(ptr : u32) -> u32 {
    kfree(ptr as *mut u32);
    return 0;
}
unsafe fn handle_spawn(stack_size : u32, ip : u32, QM : u32, data : u32, data_len : u32, name : u32) -> u32 {
    return sched.new_process(stack_size, ip, QM, data as *mut u32, data_len, name as *mut char) as u32
}
unsafe fn handle_waitpid(pid : u32) -> u32 {
    if sched.current.is_null()
    || !sched.tree_has_pid(pid as i32) {
        return 1;
    }
    (*sched.current).waitpid = pid as i32;
    return 0;
}
unsafe fn handle_kill(pid : u32) -> u32 {
    let pcb = sched.get_pcb(pid as i32);
    if pcb.is_null() {
        return 1;
    }
    (*pcb).kill = true;
    return 0;
}
unsafe fn handle_nproc() -> u32 {
    let mut n_in_tree = (*sched.schedule).len;
    if !sched.current.is_null() {
        n_in_tree += 1;
    }
    return n_in_tree as u32;
}
unsafe fn handle_procs(out : u32) -> u32 {
    let all_pcbs = sched.collect_all_procs();
    if all_pcbs.is_null() {
        return 1;
    }
   
    let mut n = 0;
    let mut ptr = all_pcbs;
    while !(*ptr).is_null() {
        n += 1;
        ptr = ptr.offset(1);
    }
   
    let proc_infos = kmalloc(n * core::mem::size_of::<process_info>() as u32) as *mut process_info;

    if proc_infos.is_null() {
        println!("Could not allocate process_info array!");
    }

    for i in 0..n {
        let pcb : &PCB = &**all_pcbs.offset(i as isize);
        let info = process_info {
            pid      : pcb.pid,
            vruntime : pcb.vruntime,
            name     : pcb.name,
            waitpid  : pcb.waitpid,
            sleep    : pcb.sleep
        };

        *proc_infos.offset(i as isize) = info;
    }

    let out_ptr = out as *mut *const process_info;
    *out_ptr = proc_infos;

    return n;
}
unsafe fn handle_sleep(secs : u32) -> u32 {
    if sched.current.is_null() {
        return 1;
    }
    (*sched.current).sleep = (100 * secs) as i16;
    return 0;
}
unsafe fn handle_mypid() -> u32 {
    if sched.current.is_null() {
        return 0xFFFFFFFF;
    }
    return (*sched.current).pid as u32;
}
