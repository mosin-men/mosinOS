/* UART code goes here. */

/* Define device-specific frequencies and memory-map addresses. These all
 * come from the lab writeup, so hopefully no further explanation is
 * needed. */
 /* Some of multi-line IFDEF feature would be pretty killer here. */
#[cfg(feature="qemu")]
mod uart_config {
    pub static FREQ: u32 = 65_000_000;
    pub static ADDR: u32 = 0x1001_3000;
}

#[cfg(target="e31")]
mod uart_config {
    static FREQ: u32 = 32_500_000;
    static ADDR: u32 = 0x2000_0000;
}

#[cfg(target="hifive")]
mod uart_config {
    static FREQ: u32 = 17_422_745;
    static ADDR: u32 = 0x1001_3000;
}

static BAUD_RATE: u32 = 115_200;
static UART_DIVISOR: u32 = uart_config::FREQ / BAUD_RATE - 1;

enum UartRegisters {
    TXDATA  = 0x00,
    RXDATA  = 0x01,
    TXCTRL  = 0x02,
    RXCTRL  = 0x03,
    IE      = 0x04,
    IP      = 0x05,
    DIV     = 0x06,
}

/* Ideally, we would actually use some sort of singleton here. But, Rust does
   not really have a singleton without std, and we don't want to use
   unnecessary global state. So, for now, we do it this way, and we just make
   sure not to call UartDevice::new() more than once :-/ */
pub struct UartDevice {
    div: u32,
    in_use: bool,
}

impl UartDevice {
    pub fn configure() {
        let mem: *mut u32 = uart_config::ADDR as *mut u32;
        let ptr: isize = UartRegisters::DIV as isize;
        unsafe {
            let fuckyou = mem.offset(ptr);
            *mem.offset(ptr) = UART_DIVISOR;
        }
        loop {}
    }

    pub fn get_info(&self) -> u32 {
        self.div
    }
}
