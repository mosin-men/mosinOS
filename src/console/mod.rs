
mod uart;

use core::fmt::{Write, Error};

pub const CON : &'static Console = &Console{  };

const CON_BUFF_SZ : usize = 256;

pub struct Console {
    _buff : [char; CON_BUFF_SZ],
    buff  : StacVec<char>  
}

impl Console {
    pub fn init() { uart::UartDevice::configure(); }
}

impl core::fmt::Write for Console {
    fn write_str(&mut self, s: &str) -> Result<(), Error> {
        Ok(())
    }
}   
