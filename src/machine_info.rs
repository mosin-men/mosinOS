/* Specific information about the machine we are running on
 * such as clock frequency, memory mapped machine registers, etc.
 *
 * */

#[cfg(feature="qemu")]
pub const FREQ: u32 = 65_000_000;

#[cfg(target="e31")]
pub const FREQ: u32 = 32_500_000;

#[cfg(target="hifive")]
pub const FREQ: u32 = 17_422_745;

pub const CLINT_BASE : u32 = 0x0200_0000;

pub enum ClintRegister {
    MSIP       = 0x0000,
    MTIMECMPLO = 0x4000,
    MTIMECMPHI = 0x4004,
    MTIMELO    = 0xbff8,
    MTIMEHI    = 0xbffc,
}

pub fn get_clint_register(reg : ClintRegister) -> &'static mut u32 {
    unsafe {
        ((CLINT_BASE + (reg as u32)) as *mut u32).as_mut().unwrap()
    }
}
