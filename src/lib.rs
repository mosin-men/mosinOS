#![feature(panic_info_message,allocator_api,asm,lang_items,compiler_builtins_lib)]
//We are not permitted to use the standard library since it isn't written for our operating system
#![no_std]

// Module imports
mod console;
mod drivers;
mod utils;
use core::fmt::Write;
#[macro_use(print, println)]


//The eh_personality tells our program how to unwind. We aren't going to write that, so tell
//it to do nothing.
#[lang = "eh_personality"]
pub extern fn eh_personality() {}

//Abort will be used when panic can't
#[no_mangle]
fn abort() -> !
{
    loop {}
}

//Panic handler will execute whenever our rust code panics. -> ! means that this function won't return,
//so we have to make sure it doesn't.
#[panic_handler]
fn panic(_info: &core::panic::PanicInfo) -> ! {
    abort()
}

#[no_mangle]
fn main() -> ! {
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

#[no_mangle]
fn trap_handler() {
  console::init();
  println!("In trap Handler");
  loop{};
}
