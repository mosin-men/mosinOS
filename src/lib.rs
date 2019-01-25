#![feature(lang_items, core_intrinsics)]
#![no_std]
#![feature(compiler_builtins_lib)]
//use core::intrinsics;
use core::panic::PanicInfo;

extern crate compiler_builtins;

#[no_mangle]
fn main() {
    loop { }
}

// These functions are used by the compiler, but not
// for a bare-bones hello world. These are normally
// provided by libstd.
#[lang = "eh_personality"]
#[no_mangle]
pub extern fn rust_eh_personality() {
}

// This function may be needed based on the compilation target.
#[lang = "eh_unwind_resume"]
#[no_mangle]
pub extern fn rust_eh_unwind_resume() {
}

#[lang = "panic_impl"]
#[no_mangle]
pub extern fn rust_begin_panic(_info: &PanicInfo) -> ! {
    //unsafe { intrinsics::abort() }
    loop { }
}
