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

/* Offsets for UART registers. Actual addresses can be calculated by:
   uart_config::ADDR + (<register> * 4). */
enum UartRegisters {
    TXDATA  = 0x00,
    RXDATA  = 0x01,
    TXCTRL  = 0x02,
    RXCTRL  = 0x03,
    IE      = 0x04,
    IP      = 0x05,
    DIV     = 0x06,
}

/* Since this is a memory-mapped device, we can just have an empty struct
   with some implementation functions for now and directly manipulate the
   memory. In the future (when we have processes), we're going to need some
   state so we can lock it out, but this will do for now. */
pub struct UartDevice {}

impl UartDevice {
    /* Load the divisor into the UartRegisters::DIV register. This MUST be
       called prior to attempting to read from/write to the UART. */
    pub fn configure() {
        let mem: *mut u32 = uart_config::ADDR as *mut u32;

        /* Enable both send and receive. Consider breaking this out into
           separate functions later, for finer control. */
        /* Set bit 32 (1 << 31) and bit 31 (1 << 30) */
        let mut txreg: u32 = 0;
        txreg |= (1 << 31);
        txreg |= (1 << 30);
        
        /* Set bit 32 (1 << 31) */
        let mut rxreg: u32 = 0;
        rxreg |= (1 << 31);

        /* Populate the memory for the divisor, the transmit control register,
           and the receive control register */
        unsafe {
            *mem.offset(UartRegisters::DIV as isize) = UART_DIVISOR;
            *mem.offset(UartRegisters::TXCTRL as isize) = txreg;
            *mem.offset(UartRegisters::RXCTRL as isize) = rxreg;
        }
    }

    pub fn uart_read() -> char {
        /* Read entire register into u32, if bit 31 is 0 return char, otherwise
           return false. DO NOT BLOCK */
        let mem: *mut u32 = uart_config::ADDR as *mut u32;

        /* Read from the FIFO and see if data is available. */
        let val: u32;
        unsafe {
            val = mem.offset(UartRegisters::RXDATA as isize).read_volatile();
        }

        /* Make sure we actually got something. If so, return it. Otherwise,
           return NOTHING */
        match val & 1 {
            1   => 0 as char,
            _   => (((val >> 24) & 0xFF) as u8) as char,
        }
    }

    pub fn uart_write(out: char) {
        let mem: *mut u32 = uart_config::ADDR as *mut u32;
        let mut fifo_full: u32;
        /* Check to ensure the FIFO isn't full and spin if it is. */
        loop {
            unsafe {
                fifo_full = mem.offset(UartRegisters::TXDATA as isize).read_volatile();
            }
            if fifo_full & 1 == 0 {
                break;
            }
        }

        /* Since we're out of the above loop, we can write the char to data */
        unsafe {
            mem.offset(UartRegisters::TXDATA as isize).write_volatile(out as u32);
        }
    }
}
