use crate::console as console;
use core::fmt::Write;

static PMP_MASKS: [u32; 4] = [0xFF_FF_FF_00,
                              0xFF_FF_00_FF,
                              0xFF_00_FF_FF,
                              0x00_FF_FF_FF,
                             ];
#[derive(Copy, Clone)]
pub enum PMP_MODES{
    TOR,
    NA4,
    NAPOT,
}

pub fn pmp_set(idx: usize, read: bool, write: bool, exec: bool, mode: PMP_MODES, addr: u32)
{
    let mut pmpcfg: u32 = 1;
    let pmpcfg_idx = idx >> 2;
    let idx = idx & 0x3;
    let x: u8 = get_perm_mask(read as u32, write as u32, exec as u32) | get_mode_mask(mode);
    let x: u32 = (x as u32) << (idx*8);
    unsafe{

        match pmpcfg_idx {
            0 => {
            asm!("csrr $0, pmpcfg0"   :
                 "=r"(pmpcfg)         :
                                      :
                                      :
                 );
            }
            1 => {
            asm!("csrr $0, pmpcfg1"   :
                 "=r"(pmpcfg)         :
                                      :
                                      :
                 );
            }
            _ => {
                println!("PMPCFG_IDX out of range!");
            }
        }
    }

    pmpcfg &= PMP_MASKS[idx];
    pmpcfg |= x;
    unsafe {
        match pmpcfg_idx {
            0 => {
                asm!("csrrw zero, pmpcfg0, $0" :
                                        :
                     "r"(pmpcfg)        :
                                        :
                );
            }
            1 => {
                asm!("csrrw zero, pmpcfg1, $0" :
                                        :
                     "r"(pmpcfg)        :
                                        :
                     );
            }
            _ => {}
        }

    }

    set_pmp_addr(idx, mode, addr);


}

fn get_mode_mask(mode: PMP_MODES) -> u8
{
    match mode{
        PMP_MODES::TOR   => 0x08,
        PMP_MODES::NA4   => 0x10,
        PMP_MODES::NAPOT => 0x18,
    }
}

fn get_perm_mask(read: u32, write: u32, exec: u32) -> u8
{
    match (exec, write, read){
        (0, 0, 0) => 0x00,
        (0, 0, 1) => 0x01,
        (0, 1, 0) => 0x02,
        (0, 1, 1) => 0x03,
        (1, 0, 0) => 0x04,
        (1, 0, 1) => 0x05,
        (1, 1, 0) => 0x06,
        (1, 1, 1) => 0x07,
        (_, _, _) => {println!("ERROR: UNKNOWN pmp permission mode"); 0}
    }
 }


fn set_pmp_addr(idx: usize, mode: PMP_MODES, _addr:  u32){
    let mut addr = _addr;
    match mode {
        PMP_MODES::NAPOT  => {
                            addr = !(addr >> 3);
                            },
        PMP_MODES::TOR    => {
                            addr = (addr);
                            },
        _                 => {} 
    }
    unsafe{
        match idx {
            0 => { asm!("csrw pmpaddr0, $0" : /*no outputs*/: "r"(addr)) },
            1 => { asm!("csrw pmpaddr1, $0" : /*no outputs*/: "r"(addr)) },
            2 => { asm!("csrw pmpaddr2, $0" : /*no outputs*/: "r"(addr)) },
            3 => { asm!("csrw pmpaddr3, $0" : /*no outputs*/: "r"(addr)) },
            4 => { asm!("csrw pmpaddr4, $0" : /*no outputs*/: "r"(addr)) },
            5 => { asm!("csrw pmpaddr5, $0" : /*no outputs*/: "r"(addr)) },
            6 => { asm!("csrw pmpaddr6, $0" : /*no outputs*/: "r"(addr)) },
            7 => { asm!("csrw pmpaddr7, $0" : /*no outputs*/: "r"(addr)) },
            _ => {}
        }
    } 
}
