mod uart;
//mod stackvec;

use core::fmt::{Write, Error};

//pub const CON : &'static Console = &Console{  };

const CON_BUFF_SZ : usize = 256;

pub struct Console {
    //_buff : [char; CON_BUFF_SZ],
    //buff  : StackVec<char>  
}

impl Console {
    pub fn init(&mut self) { uart::UartDevice::configure(); }
    pub fn putc(&self, c : char) {
        uart::UartDevice::uart_write(c);
    }
    pub fn getc(&self) -> char {
        // Error checking required, since UART driver is unsafe
        uart::UartDevice::uart_read()
    }
}

impl core::fmt::Write for Console {
    fn write_str(&mut self, s: &str) -> Result<(), Error> {
        for c in s.chars() {
            self.putc(c);
        }
        Ok(())
    }
}
