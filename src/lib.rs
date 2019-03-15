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

    let mut t : rbtree<i32, f32> = rbtree::new();
    t.insert(2, 1.23);
    t.print();
    t.insert(1, 4.56);
    t.print();
    t.insert(0, 7.89);
    t.print();
    t.insert(7, 8.6);
    t.print();
    t.insert(16, 7.5);
    t.print();
    t.insert(42, 3.0);
    t.print();
    t.insert(37, 0.9);
    t.print();
    t.insert(165, 0.0);
    t.print();
    t.insert(-123, 55555.5555);
    t.print();

    if let Some((k, v)) = t.first() {
        println!("item with lowest key: ({:?}, {:?})", k, v);
    }
    
    if let Some((k, v)) = t.lookup(-1) {
        println!("This shouldn't happen");
    }
    
    if let Some((k, v)) = t.lookup(165) {
        println!("Found key {:?} with val {:?}", k, v);
    }

    t.delete(16); println!("deleted 16");
    t.print();
    t.delete(1); println!("deleted 1");
    t.print();
    t.delete(7); println!("deleted 7");
    t.print();
    t.delete(42); println!("deleted 42");
    t.print();
    t.delete(165); println!("deleted 165");
    t.print();
    t.delete(2); println!("deleted 2");
    t.print();
    t.delete(37); println!("deleted 37");
    t.print();
    t.delete(0); println!("deleted 0");
    t.print();
    t.delete(-123); println!("deleted -123");
    t.print();

    t.dispose();

    /* Hold the OS here */
    loop{}
}

