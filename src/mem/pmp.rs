use crate::console as console;
use core::fmt::Write;

pub enum PMP_MODES{
    TOR,
    NA4,
    NAPOT,
}

pub fn pmp_set(idx: u8, read: bool, write: bool, exec: bool, mode: PMP_MODES, addr: u32)
{
    let mut pmpcfg: u32 = 0;
    let pmpcfg_idx = idx >> 2;
    let idx = idx & 0x3;
    let x: u8 = get_perm_mask(read as u32, write as u32, exec as u32) | get_mode_mask(mode);
    let x: u32 = (x as u32) << (idx*8);
    unsafe{
        match pmpcfg_idx {
            0 => {
            asm!("csrr x31, pmpcfg0" :
                 "={x31}"(pmpcfg)   :
                                     :
                 "x31"               : 
                 );
            }
            1 => {
            asm!("csrr x31, pmpcfg1" :
                 "={x31}"(pmpcfg)    :
                                     :
                 "x31"               : 
                 );
            }
            _ => {
                println!("PMPCFG_IDX out of range!");
            }
        }
    }
    println!("pci: {} idx: {} x: {:#010X} pmp: {:#010X}", pmpcfg_idx, idx, x, pmpcfg);
     
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
