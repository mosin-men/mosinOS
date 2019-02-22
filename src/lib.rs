#![feature(panic_info_message,allocator_api,asm,lang_items,compiler_builtins_lib)]
//We are not permitted to use the standard library since it isn't written for our operating system
#![no_std]


/**************************************************************
  Macros
**************************************************************/
#[macro_export]
macro_rules! print {
  ($($arg:tt)*) => {
    let mut con = console::Console();
    if let Err(_c) = write!(con, "{}", format_args!($($arg)*)){
      //some error handling?
    }
  };
}

#[macro_export]
macro_rules! println {
  () => {
    let mut con = console::Console{};
    if let Err(_c) = write!(con, "\r\n"){
      //some error handling?
    }
  };
  ($($arg:tt)*) => {
    let mut con = console::Console{};
    if let Err(_c) = write!(con, "{}\r\n", format_args!($($arg)*)){
      //some error handling?
    }
  };
}

/**************************************************************
  Module Imports
**************************************************************/
mod console;
mod drivers;
mod utils;
mod machine_info;
mod trap;
use core::fmt::Write;


//The eh_personality tells our program how to unwind. We aren't going to write that, so tell
//it to do nothing.
#[lang = "eh_personality"]
pub extern fn eh_personality() {}

//Abort will be used when panic can't
#[no_mangle]
fn abort() -> !
{
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
fn main() -> ! {
    trap::reset_timers();
    /* Example of using the console to get characters,
     * then printing them back out. */
    console::init();
    unsafe{
      asm!("ecall");
    }
    loop {
        if let Some(c) = console::getc() {
            println!("Got a character: {}", c);
        }
    };
}

