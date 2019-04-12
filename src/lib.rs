#![allow(warnings)]
#![feature(panic_info_message,allocator_api,asm,lang_items,compiler_builtins_lib,const_raw_ptr_to_usize_cast)]
//We are not permitted to use the standard library since it isn't written for our operating system
#![no_std]


/**************************************************************
  Macros
**************************************************************/
#[macro_export]
macro_rules! print {
  ($($arg:tt)*) => {
    {
      let mut con = console::Console{};
      if let Err(_c) = write!(con, "{}", format_args!($($arg)*)){
        //some error handling?
      }
    }
  };
}

#[macro_export]
macro_rules! println {
  () => {
    {
      let mut con = console::Console{};
      if let Err(_c) = write!(con, "\r\n"){
        //some error handling?
      }
    }
  };
  ($($arg:tt)*) => {
    {
      let mut con = console::Console{};
      if let Err(_c) = write!(con, "{}\r\n", format_args!($($arg)*)){
        //some error handling?
      }
    }
  };
}

/**************************************************************
  Module Imports
**************************************************************/
mod console;
mod atomics;
mod drivers;
mod utils;
mod machine_info;
mod trap;
mod syscalls;
mod mem;
mod scheduler;
mod libs;
use crate::mem::heap::{*};
use core::fmt::Write;
use crate::atomics::barrier as barrier;
use crate::atomics::locks as locks;
use crate::mem::pmp::PMP_MODES as pmp_modes;
use crate::utils::rbtree::rbtree;
use crate::syscalls::{do_msyscall, UMODE, MMODE, _MMODE_SWITCH, _UMODE_SWITCH};
use crate::libs::syscalls::{*};

//The eh_personality tells our program how to unwind. We aren't going to write that, so tell
//it to do nothing.
#[lang = "eh_personality"]
pub extern fn eh_personality() {}

//Abort will be used when panic can't
#[no_mangle]
fn abort() -> !
{
    println!("WE DUMB");
    loop {
      unsafe{
        asm!("wfi");
      }
    }
}


//Panic handler will execute whenever our rust code panics. -> ! means that this function won't return,
//so we have to make sure it doesn't.
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    abort()
}

#[no_mangle]
unsafe fn proc_a() -> ! {
    loop{
        println!("IN A");
        exit();
    }
}

#[no_mangle]
unsafe fn proc_b() -> ! {
    loop{
        println!("IN B");
        exit();
    }
}

#[no_mangle]
fn main() -> () {

    /* Initialize */
    heap_init();
    console::init();
    unsafe{
    scheduler::sched.init();
    }
    /* Turns on timer interrupts */
    unsafe{
      asm!("li t1, 0x80\ncsrs mie, t1":::"t1":"volatile");
      asm!("li t1, 0x8\ncsrs mstatus, t1":::"t1":"volatile");
    }

    /* enter user mode */
    unsafe{ _UMODE_SWITCH(); }
 
    let pid = spawn(512, proc_a as u32, 1, core::ptr::null::<u32>() as *mut u32, 0, "a");
    println!("pid of new process: {}", pid);

    /* Hold the OS here */
    loop{
        unsafe{
            asm!("wfi");
        }
    }
}

