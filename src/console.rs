use crate::drivers::uart as uart;
use core::fmt::{Write, Error};

const CON_BUFF_SZ : usize = 256;

/*******************
  print and println
 ******************/
#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => (
        {
            let mut con = console::Console{};
            write!(con, "{}", format_args!($($arg)*));
        }
    );
}
#[macro_export]
macro_rules! println {
    () => (
        {
            let mut con = console::Console{};
            write!(con, "\r\n");
        }
    );
    ($($arg:tt)*) => (
        {
            let mut con = console::Console{};
            write!(con, "{}\r\n", format_args!($($arg)*));
        }
    );
}


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
