use crate::console as console;
use crate::machine_info::{*};
use core::fmt::Write;

extern "C" {
//  static GLOBAL_CTX: *mut usize;
}

const  INTERRUPT: u32 = 0x80000000;
const  CODE_MASK: u32 = 0x7FFFFFFF;
const  INST_MASK: u32 = 0x00000003;

const   USOFTWARE: u32  = 0;
const   SSOFTWARE: u32  = 1;
const   MSOFTWARE: u32  = 3;
const   UTIMER: u32     = 4;
const   STIMER: u32     = 5;
const   MTIMER: u32     = 7;
const   UEXTERNAL: u32  = 8;
const   SEXTERNAL: u32  = 9;
const   MEXTERNAL: u32  = 11;

const   IADDMISS: u32   = 0;
const   IACCFAULT: u32  = 1;
const   ILLINS: u32     = 2;
const   BREAK: u32      = 3;
const   LADDMISS: u32   = 4;
const   LACCFAULT: u32  = 5;
const   SADDMISS: u32   = 6;
const   SACCFAULT: u32  = 7;
const   UECALL: u32     = 8;
const   SECALL: u32     = 9;
const   MECALL: u32     = 11;
const   IPAGEFAULT: u32 = 12;
const   LPAGEFAULT: u32 = 13;
const   SPAGEFAULT: u32 = 15;

#[no_mangle]
fn trap_handler(cause: u32, mepc: u32) -> u32{
  let code = cause & CODE_MASK;
  let sync = cause & INTERRUPT;
  match sync {
    INTERRUPT => {
        ahandler(code);
        mepc
    }
    0         => {
      shandler(code);
      update_mepc(mepc)
    }
    _         => {
      println!("unknown trap cause {}", cause);
      0
    }
  }
}

fn ahandler(code: u32){
  match code {
    USOFTWARE      => println!("USER MODE SOFTWARE INTERRUPT"),
    SSOFTWARE      => println!("SUPERVISOR MODE SOFTWARE INTERRUPT"),
    MSOFTWARE      => println!("MACHINE MODE SOFTWARE INTERRUPT"),
    UTIMER         => println!("USER MODE TIMER INTERRUPT"),
    STIMER         => println!("SUPERVISOR MODE TIMER INTERRUPT"),
    MTIMER         => { 
      println!("MACHINE MODE TIMER INTERRUPT");
      reset_timers();
    },
    UEXTERNAL      => println!("USER MODE EXTERNAL INTERRUPT"),
    SEXTERNAL      => println!("SUPERVISOR MODE EXTERNAL INTERRUPT"),
    MEXTERNAL      => println!("MACHINE MODE EXTERNAL INTERRUPT"),
    _              => println!("UKNOWN ASYNCRONOUS INTERRUPT CODE"),
  }
  
}

fn shandler(code: u32){
  match code {
    IADDMISS        => println!("INSTRUCTION ADDRESS MISSALIGNED"),
    IACCFAULT       => println!("INSTRUCTION ACCESS FAULT"),
    ILLINS          => println!("ILLEGAL INSTRUCTION"),
    BREAK           => println!("BREAK"),
    LADDMISS        => println!("LOAD ADDRESS MISSALIGNED"),
    LACCFAULT       => println!("LOAD ACCESS FAULT"),
    SADDMISS        => println!("STORE ADDRESS MISSALIGNED"),
    SACCFAULT       => println!("STORE ACCESS FAULT"),
    UECALL          => println!("USER MODE ECALL"),
    SECALL          => println!("SUPERVISOR MODE ECALL"),
    MECALL          => println!("MACHINE MODE ECALL"),
    IPAGEFAULT      => println!("INSTRUCTION PAGE FAULT"),
    LPAGEFAULT      => println!("LOAD PAGE FAULT"),
    SPAGEFAULT      => println!("STORE PAGE FAULT"),
    _               => println!("UNKNOWN SYNCRONOUS TRAP CODE"),
  }
}

fn update_mepc(mepc: u32) -> u32{
  unsafe{
    let instruction: u32 = *(mepc as *const u32);
    match instruction & INST_MASK {
      INST_MASK => mepc + 4,
      _         => mepc + 2,
    }
  }
}

pub fn reset_timers() {
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

// pub fn reset_timers() {
//     unsafe {
//         let mtimelo    : *mut u32 = get_clint_register(ClintRegister::MTIMELO);
//         let mtimehi    : *mut u32 = get_clint_register(ClintRegister::MTIMEHI);
//         let mtimecmplo : *mut u32 = get_clint_register(ClintRegister::MTIMECMPLO);
//         let mtimecmphi : *mut u32 = get_clint_register(ClintRegister::MTIMECMPHI);

//         println!("{:p}", mtimecmplo);
//         println!("{:p}", mtimecmphi);

//         let cur_mtimelo   : u32 = *mtimelo;
//         let cur_mtimehi   : u32 = *mtimehi;
//         let cur_mtimecmplo: u32 = *mtimecmplo;
//         let cur_mtimecmphi: u32 = *mtimecmphi;

//         let interval = (FREQ as u64) / 100;
        

//         let mtime64: u64         = ((cur_mtimehi as u64) << 32) + (cur_mtimelo as u64);
//         let cur_mtimecmp64: u64  = ((cur_mtimecmphi as u64) << 32) + (cur_mtimecmplo as u64);
//         let mtimecmp64: u64      = mtime64 + interval;
//         let new_mtimecmphi : u32 = (mtimecmp64 >> 32) as u32;
//         let new_mtimecmplo : u32 = (mtimecmp64 & 0x00000000FFFFFFFF) as u32;

//         // *mtimecmplo = 0xFFFFFFFF;
//         *mtimecmplo = new_mtimecmplo;
//         *mtimecmphi = new_mtimecmphi;
//         println!("mtimecmp: {:X}:{:X}", *mtimecmphi, *mtimecmplo);

//         // println!("old mtime:    {:X}", mtime64);
//         // println!("cur mtime:    {:X}:{:X}", *mtimehi, *mtimelo);
//         // println!("new mtimecmp: {:X}:{:X}", *mtimecmphi, *mtimecmplo);
//     }
// }
