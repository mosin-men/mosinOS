use crate::console;
use crate::machine_info::{*};
use crate::utils::rbtree::rbtree;
use core::fmt::Write;
use core::ptr::null;

extern "C" {
    static GLOBAL_CTX: [u32; 32];
}

#[derive(Clone, Debug)]
pub struct PCB {
    context            : [u32; 32],
    pc                 :  u32,
}

pub struct scheduler {
    schedule: rbtree<u32, *mut u32>
}

impl scheduler {
    pub unsafe fn init(){
        scheduler::reset_timers();
    }

    pub fn update_schedule(mepc: u32)-> u32 {
        scheduler::reset_timers();
        mepc
    }

    fn reset_timers() {
        let mtimelo        : &mut u32 = get_clint_register(ClintRegister :: MTIMELO);
        let mtimehi        : &mut u32 = get_clint_register(ClintRegister :: MTIMEHI);
        let mtimecmplo     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPLO);
        let mtimecmphi     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPHI);

        let cur_mtimelo    : u32      = *mtimelo;
        let cur_mtimehi    : u32      = *mtimehi;

        let interval = (FREQ as u64) / 1;

        let mtime64        : u64 = ((cur_mtimehi as u64) << 32) + (cur_mtimelo as u64);
        let mtimecmp64     : u64 = mtime64 + interval;
        let new_mtimecmphi : u32 = (mtimecmp64 >> 32) as u32;
        let new_mtimecmplo : u32 = (mtimecmp64 & 0x00000000FFFFFFFF) as u32;

        *mtimecmplo = new_mtimecmplo;
        *mtimecmphi = new_mtimecmphi;
    }
}
