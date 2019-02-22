use crate::console as console;
use crate::machine_info::{*};
use core::fmt::Write;

extern "C" {
//  static GLOBAL_CTX: *mut usize;
}

#[no_mangle]
fn trap_handler(cause: u32, mepc: u32){
  println!("In trap Handler");
  println!("{}, {:X}", cause, mepc);
}

// # New comparand is in a1:a0.
// li t0, -1
// sw t0, mtimecmp   # No smaller than old value.
// sw a1, mtimecmp+4 # No smaller than new value.
// sw a0, mtimecmp   # New value.

pub fn reset_timers() {
    let mtimelo    : &mut u32 = get_clint_register(ClintRegister::MTIMELO);
    let mtimehi    : &mut u32 = get_clint_register(ClintRegister::MTIMEHI);
    let mtimecmplo : &mut u32 = get_clint_register(ClintRegister::MTIMECMPLO);
    let mtimecmphi : &mut u32 = get_clint_register(ClintRegister::MTIMECMPHI);

    let interval = (FREQ / 100) as u64;

    let mtime64    = ((*mtimehi as u64) << 32) + (*mtimelo as u64);
    let mtimecmp64 = mtime64 + interval; 

    *mtimecmplo = 0xFFFFFFFF;
    *mtimecmphi = (mtimecmp64 >> 32) as u32;
    *mtimecmplo = (mtimecmp64 & 0x00000000FFFFFFFF) as u32;
}
