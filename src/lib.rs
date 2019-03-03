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
      let mut con = console::Console();
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
use core::fmt::Write;
use crate::atomics::barrier as barrier;
use crate::atomics::locks as locks;

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

    /* Initialize the heap */
    mem::heap::heap_init();

    /* Our whole heap is 14,208 bytes. This allocation requires
     * 14,204 bytes, which should mean that no further allocations are
     * possible.
     */
    println!("{:p}", mem::heap::allocate(14200));
    println!("{:p}", mem::heap::allocate(4));
    println!("{:p}", mem::heap::allocate(4));
    println!("{:p}", mem::heap::allocate(4));

    /* Hold the OS here */
    loop{}
}

