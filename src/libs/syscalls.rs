
use crate::syscalls::{*};

pub fn exit() { unsafe { syscall(EXIT, 0, 0, 0, 0, 0, 0); } }

pub fn alloc(size: u32) -> *mut u32 { unsafe {
    return syscall(ALLOC, size, 0, 0, 0, 0, 0) as *mut u32;
}
}

pub fn free<T>(addr: *mut T) { unsafe {
    syscall(FREE, addr as u32, 0, 0, 0, 0, 0);
}
}

pub fn spawn(stack_size : u32, ip : u32, QM : u32, data : *mut u32, data_len : u32, name : &'static str) -> i32 { unsafe {
    return syscall(SPAWN, stack_size, ip, QM, data as u32, data_len, name.as_bytes().as_ptr() as u32) as i32;
}
}

pub fn waitpid(pid : i32) -> i32 { unsafe {
    return syscall(WAITPID, pid as u32, 0, 0, 0, 0, 0) as i32;
}
}

pub fn kill(pid : i32) -> i32 { unsafe {
    return syscall(KILL, pid as u32, 0, 0, 0, 0, 0) as i32;
}
}

pub fn nproc() -> u32 { unsafe {
    return syscall(NPROC, 0, 0, 0, 0, 0, 0);
}
}

pub fn procs() -> *const process_info { unsafe {
    return syscall(PROCS, 0, 0, 0, 0, 0, 0) as *const process_info;
}
}

pub fn sleep(secs : u32) { unsafe {
    syscall(SLEEP, secs, 0, 0, 0, 0, 0);
}
}
