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
mod fs;
use crate::mem::heap::{*};
use core::fmt::Write;
use crate::atomics::barrier as barrier;
use crate::atomics::locks as locks;
use crate::mem::pmp::PMP_MODES as pmp_modes;
use crate::utils::rbtree::rbtree;
use crate::syscalls::{do_msyscall, UMODE, MMODE, _MMODE_SWITCH, _UMODE_SWITCH};
use crate::libs::syscalls::{*};
use crate::fs::ext2 as ext2;

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
unsafe fn proc_a() -> !{
    loop{
        asm!("wfi");
        println!("IN A");
    }
}

#[no_mangle]
unsafe fn init() -> !{
    let pid = spawn(2048, proc_a as u32, 1, core::ptr::null::<u32>() as *mut u32, 0, "a");
    let pid = spawn(2048, proc_b as u32, 1, core::ptr::null::<u32>() as *mut u32, 0, "b");
    loop{
        asm!("wfi");
    }
}

#[no_mangle]
unsafe fn proc_b() -> ! {
    loop{
        asm!("wfi");
        println!("IN B");
    }
}

unsafe fn mecall(code:u32){
    asm!("ecall");
}


#[no_mangle]
fn main() -> () {
    /* Initialize */
    let mut fs = ext2::Ext2FS::init();
    fs.get_fs_info();
    fs.read_block_descriptors();
    fs.read_directory_inode();
    let mut t = fs.fs_cd("Blurrrrrrrrr");
    println!("{}.", match t {
        0   => "Directory change succeeded",
        1   => "Target not a directory",
        2   => "Target not present",
        _   => "Undefined error",
    });
    t = fs.fs_cd("test.txt");
    println!("{}.", match t {
        0   => "Directory change succeeded",
        1   => "Target not a directory",
        2   => "Target not present",
        _   => "Undefined error",
    });
    t = fs.fs_cd("test");
    println!("{}.", match t {
        0   => "Directory change succeeded",
        1   => "Target not a directory",
        2   => "Target not present",
        _   => "Undefined error",
    });
    fs.read_directory_inode();
    t = fs.fs_cd("..");
    println!("{}.", match t {
        0   => "Directory change succeeded",
        1   => "Target not a directory",
        2   => "Target not present",
        _   => "Undefined error",
    });
    fs.read_directory_inode();
    /*unsafe {
        let ptr: *const u32 = &mut __fs_start as *const u32;
        println!("{:p}", ptr);
    }*/
    heap_init();
    console::init();
    unsafe{
    scheduler::sched.init();
    }
    /* Turns on timer interrupts */
    /*unsafe{
      let pid = scheduler::sched.new_process(2048, init as u32, 1, core::ptr::null::<u32>() as *mut u32, 0, "init".as_bytes().as_ptr() as *const char);
      println!("pid of init: {}", pid);
      asm!("li t1, 0x80\ncsrs mie, t1":::"t1":"volatile");
      asm!("li t1, 0x8\ncsrs mstatus, t1":::"t1":"volatile");
      loop { asm!("wfi"); }
    }*/


    /* enter user mode */
    // unsafe{
    // mecall(0);
    // }

    unsafe{
      scheduler::sched.new_process(2048, init as u32, 1, core::ptr::null::<u32>() as *mut u32, 0, "init".as_bytes().as_ptr() as *mut char);
      asm!("li t1, 0x80\ncsrs mie, t1":::"t1":"volatile");
      asm!("li t1, 0x8\ncsrs mstatus, t1":::"t1":"volatile");
      mecall(0);
      asm!("wfi");
    }


    /* Hold the OS here */
    loop{
        unsafe{
            asm!("wfi");
        }
    }
}

