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
use crate::mem::heap::{*};
use core::fmt::Write;
use crate::atomics::barrier as barrier;
use crate::atomics::locks as locks;
<<<<<<< HEAD
use crate::mem::pmp::PMP_MODES as pmp_modes;
||||||| merged common ancestors
=======
use crate::utils::rbtree::rbtree;
>>>>>>> 737fa7128a229f8eb291d0ae663ad7e7b8c79245

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

fn syscall(code: u32){
    unsafe {
        asm!("ecall");
    }
}

fn msyscall(code: u32){
    unsafe {
        asm!("ecall");
    }
}

//Panic handler will execute whenever our rust code panics. -> ! means that this function won't return,
//so we have to make sure it doesn't.
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    abort()
}

#[no_mangle]
fn main() -> () {

    /* Initialize */
    console::init();
    trap::reset_timers();

    /* Turns on timer interrupts */
    unsafe{
      asm!("li t1, 0x80\ncsrs mie, t1":::"t1":"volatile");
      asm!("li t1, 0x8\ncsrs mstatus, t1":::"t1":"volatile");
    }

    heap_init();
    heap_print(16);
    let ptr: *mut u32 = kmalloc(2);
    let ptr2: *mut u32 = kmalloc(2);
    let ptr3: *mut u32 = kmalloc(2);
    heap_print(16);
    kfree(ptr);
    heap_print(16);
    kfree(ptr3);
    heap_print(16);
    kfree(ptr2);
    heap_print(16);

    mem::pmp::pmp_set(0, true, true, false, pmp_modes::TOR, 0x80000080);
    mem::pmp::pmp_set(1, false, false, false, pmp_modes::TOR, 0x800000FF);


    let ptr: *mut u32 = kmalloc(16);
    let ptr2: *mut u32 = 0 as *mut u32;
    let pmpcfg: u32;
    let pmpaddr: u32;
    let pmpaddr2: u32;
    unsafe{
        asm!("csrr $0, pmpcfg0": "=r"(pmpcfg));
        asm!("csrr $0, pmpaddr0": "=r"(pmpaddr));
        asm!("csrr $0, pmpaddr1": "=r"(pmpaddr2));

    }

    println!("pmpcfg: {:#010X}, pmpaddr: {:#010X}, pmpaddr2: {:#010X}", pmpcfg, pmpaddr, pmpaddr2);
    msyscall(0);
    println!("HERE");
    syscall(0);
    unsafe{
        ptr.write_volatile(8);
        println!("ptr: {:p} value @ ptr: {}", ptr, ptr.read_volatile());
    }
    
    /* Hold the OS here */
    loop{
        unsafe{
            asm!("wfi");
        }
    }
}

