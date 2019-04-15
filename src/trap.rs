use crate::console as console;
use core::fmt::Write;
use crate::syscalls as syscalls;
use crate::scheduler;

extern "C" {
  static mut GLOBAL_CTX: [u32; 32];
}

const  ASYNC      : u32 = 0x80000000;
const  SYNC       : u32 = 0;
const  CODE_MASK  : u32 = 0x7FFFFFFF;
const  INST_MASK  : u32 = 0x00000003;

const  USOFTWARE  : u32 = 0;
const  SSOFTWARE  : u32 = 1;
const  MSOFTWARE  : u32 = 3;
const  UTIMER     : u32 = 4;
const  STIMER     : u32 = 5;
const  MTIMER     : u32 = 7;
const  UEXTERNAL  : u32 = 8;
const  SEXTERNAL  : u32 = 9;
const  MEXTERNAL  : u32 = 11;

const  IADDMISS   : u32 = 0;
const  IACCFAULT  : u32 = 1;
const  ILLINS     : u32 = 2;
const  BREAK      : u32 = 3;
const  LADDMISS   : u32 = 4;
const  LACCFAULT  : u32 = 5;
const  SADDMISS   : u32 = 6;
const  SACCFAULT  : u32 = 7;
const  UECALL     : u32 = 8;
const  SECALL     : u32 = 9;
const  MECALL     : u32 = 11;
const  IPAGEFAULT : u32 = 12;
const  LPAGEFAULT : u32 = 13;
const  SPAGEFAULT : u32 = 15;

struct trap_handler{}



#[no_mangle]
fn handle_trap(cause: u32, mut mepc: u32, mtval: u32) -> u32{
    let code = cause & CODE_MASK;
    let mode = cause & ASYNC;
    mepc = trap_handler::handler(code, mepc, mode, mtval);
    mepc = trap_handler::update_mepc(mepc, mode);
    return mepc;
}

impl trap_handler{
    fn handler(code: u32, mut mepc: u32, mode: u32, mtval: u32) -> u32{
        match (mode, code) {
            (ASYNC, USOFTWARE) => println!("USER MODE SOFTWARE INTERRUPT"),
            (ASYNC, SSOFTWARE) => println!("SUPERVISOR MODE SOFTWARE INTERRUPT"),
            (ASYNC, MSOFTWARE) => println!("MACHINE MODE SOFTWARE INTERRUPT"),
            (ASYNC, UTIMER)    => println!("USER MODE TIMER INTERRUPT"),
            (ASYNC, STIMER)    => println!("SUPERVISOR MODE TIMER INTERRUPT"),
            (ASYNC, MTIMER)    => {
           //     println!("MACHINE MODE TIMER INTERRUPT");
                unsafe{
                mepc = scheduler::sched.update_schedule(mepc);
                }
            },
            (ASYNC, UEXTERNAL) => println!("USER MODE EXTERNAL INTERRUPT"),
            (ASYNC, SEXTERNAL) => println!("SUPERVISOR MODE EXTERNAL INTERRUPT"),
            (ASYNC, MEXTERNAL) => println!("MACHINE MODE EXTERNAL INTERRUPT"),
            (ASYNC, _)         => println!("UKNOWN ASYNCRONOUS INTERRUPT CODE"),
            (SYNC, IADDMISS)   => println!("INSTRUCTION ADDRESS MISSALIGNED"),
            (SYNC, IACCFAULT)  => println!("INSTRUCTION ACCESS FAULT"),
            (SYNC, ILLINS)     => println!("ILLEGAL INSTRUCTION {:X}", mtval),
            (SYNC, BREAK)      => println!("BREAK"),
            (SYNC, LADDMISS)   => println!("LOAD ADDRESS MISSALIGNED"),
            (SYNC, LACCFAULT)  => println!("LOAD ACCESS FAULT: {:#010X}", mtval),
            (SYNC, SADDMISS)   => println!("STORE ADDRESS MISSALIGNED"),
            (SYNC, SACCFAULT)  => println!("STORE ACCESS FAULT: {:#010X}", mtval),
            (SYNC, UECALL)     => 
            {
                println!("USER MODE ECALL");
                unsafe{
                    let result = syscalls::do_syscall(
                        GLOBAL_CTX[10],
                        GLOBAL_CTX[11],
                        GLOBAL_CTX[12],
                        GLOBAL_CTX[13],
                        GLOBAL_CTX[14],
                        GLOBAL_CTX[15],
                        GLOBAL_CTX[16]);
                    GLOBAL_CTX[10] = result;
                }
            }
            (SYNC, SECALL)     => println!("SUPERVISOR MODE ECALL"),
            (SYNC, MECALL)     => 
            {
                println!("MACHINE MODE ECALL");
                unsafe{
                    syscalls::do_msyscall(GLOBAL_CTX[10]);
                }
            },
            (SYNC, IPAGEFAULT) => println!("INSTRUCTION PAGE FAULT"),
            (SYNC, LPAGEFAULT) => println!("LOAD PAGE FAULT"),
            (SYNC, SPAGEFAULT) => println!("STORE PAGE FAULT"),
            (SYNC, _)          => println!("UNKNOWN SYNCRONOUS TRAP CODE"),
            _                  => println!("UNKNOWN TRAP CODE AND MODE"),
        }
        return mepc;
    }

    fn update_mepc(mepc: u32, mode: u32) -> u32{
        if (mode == ASYNC) { return mepc;}
        unsafe{
            let instruction: u32 = *(mepc as *const u32);
            match instruction & INST_MASK {
                INST_MASK => mepc + 4,
                _         => mepc + 2,
            }
        }
    }
}

//pub fn reset_timers() {
//    let mtimelo        : &mut u32 = get_clint_register(clintregister :: mtimelo);
//    let mtimehi        : &mut u32 = get_clint_register(clintregister :: mtimehi);
//    let mtimecmplo     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPLO);
//    let mtimecmphi     : &mut u32 = get_clint_register(ClintRegister :: MTIMECMPHI);
//
//    let cur_mtimelo    : u32      = *mtimelo;
//    let cur_mtimehi    : u32      = *mtimehi;
//
//    let interval = (FREQ as u64) / 1;
//
//    let mtime64        : u64 = ((cur_mtimehi as u64) << 32) + (cur_mtimelo as u64);
//    let mtimecmp64     : u64 = mtime64 + interval;
//    let new_mtimecmphi : u32 = (mtimecmp64 >> 32) as u32;
//    let new_mtimecmplo : u32 = (mtimecmp64 & 0x00000000FFFFFFFF) as u32;
//
//    *mtimecmplo = new_mtimecmplo;
//    *mtimecmphi = new_mtimecmphi;
//}

