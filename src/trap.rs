use crate::console as console;
use core::fmt::Write;

extern "C" {
//  static GLOBAL_CTX: *mut usize;
}

#[no_mangle]
fn trap_handler(cause: u32, mepc: u32){
  println!("In trap Handler");
  println!("{}, {:X}", cause, mepc);
}
