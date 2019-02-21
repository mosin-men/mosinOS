use crate::drivers::uart as uart;
use core::fmt::{Error};


/*******************
       Console
 ******************/
pub struct Console { }
pub fn init() { uart::UartDevice::configure(); }
pub fn getc() -> Option<char> {
    let c = uart::UartDevice::uart_read();
    return match c {
        '\0' => None,
        _ => Some(c)
    }
}
pub fn putc(c : char) { uart::UartDevice::uart_write(c); }
impl core::fmt::Write for Console {
    fn write_str(&mut self, s: &str) -> Result<(), Error> {
        for c in s.chars() {
            putc(c);
        }
        Ok(())
    }
}
