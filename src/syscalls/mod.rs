/*  Define interface and functions to do both User mode 
 *  and System level ecalls                            */

use crate::console as console;
use crate::machine_info::{*};
use core::fmt::Write;

extern "C" {
    fn _UMODE_SWITCH();
    fn _MMODE_SWITCH();
}


const EXIT:     u32 = 1;
const WRITE:    u32 = 2;
const READ:     u32 = 3;
const ALLOC:    u32 = 4;
const FREE:     u32 = 5;
const BARRIER:  u32 = 6;

const UMODE:    u32 = 0;
const MMODE:    u32 = 3;

pub fn Do_MSysCall (code: u32) {
    match code {
        UMODE => unsafe {_UMODE_SWITCH();},
        MMODE => unsafe {_MMODE_SWITCH();},
        _     => println!("Unknown Machine Mode ECALL CODE"),
    }
}


pub fn Do_SysCall (code: u32) {
    match code {
        EXIT    => println!("SYSCALL EXIT"),
        WRITE   => println!("SYSCALL WRITE"),
        READ    => println!("SYSCALL READ"),
        ALLOC   => println!("SYSCALL ALLOC"),
        FREE    => println!("SYSCALL FREE"),
        BARRIER => println!("SYSCALL BARRIER"),
        _       => println!("Unknown User Mode ECALL CODE"),
    }
}
