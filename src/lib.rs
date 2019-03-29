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
use crate::mem::heap::{*};
use core::fmt::Write;
use crate::atomics::barrier as barrier;
use crate::atomics::locks as locks;
use crate::mem::pmp::PMP_MODES as pmp_modes;
use crate::utils::rbtree::rbtree;

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
    unsafe{
        scheduler::scheduler::init();
    }
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
    
    mem::pmp::pmp_set(0, true, true, true, pmp_modes::TOR, 0x80000080);
    mem::pmp::pmp_set(1, false, false, false, pmp_modes::TOR, 0x80000090);
    mem::pmp::pmp_set(2, false, false, false, pmp_modes::OFF, 0x0);
    mem::pmp::pmp_set(3, false, false, false, pmp_modes::OFF, 0x0);
    mem::pmp::pmp_set(4, false, false, false, pmp_modes::OFF, 0x0);
    mem::pmp::pmp_set(5, false, false, false, pmp_modes::OFF, 0x0);
    mem::pmp::pmp_set(6, false, false, false, pmp_modes::OFF, 0x0);
    mem::pmp::pmp_set(7, false, false, false, pmp_modes::OFF, 0x0);

    let ptr: *mut u32 = kmalloc(16);
    println!("ptr = {:#010X}", ptr as u32);
    let ptr2: *mut u32 = 0 as *mut u32;
    let pmpcfg0: u32;
    let pmpcfg1: u32;
    let pmpaddr0: u32;
    let pmpaddr1: u32;
    let mut mstatus : u32;
    unsafe{
        // asm!("li t1, 0x20000\ncsrs mstatus, t1":::"t1":"volatile");

        asm!("csrr $0, pmpcfg0": "=r"(pmpcfg0));
        asm!("csrr $0, pmpcfg1": "=r"(pmpcfg1));
        asm!("csrr $0, pmpaddr0": "=r"(pmpaddr0));
        asm!("csrr $0, pmpaddr1": "=r"(pmpaddr1));
    }

    println!("pmpcfg0: {:#010X}, pmpcfg1: {:#010X}, pmpaddr0: {:#010X}, pmpaddr1: {:#010X}", pmpcfg0, pmpcfg1, pmpaddr0, pmpaddr1);
    msyscall(0);
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

