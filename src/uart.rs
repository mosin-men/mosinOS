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

pub struct UartDevice {
    div: u32,
}

impl UartDevice {
    pub fn new() -> UartDevice {
        let divisor = (uart_config::FREQ / BAUD_RATE) - 1;
        let d: UartDevice = UartDevice {div: divisor};
        d
    }

    pub fn get_info(&self) -> u32 {
        self.div
    }
}
