use crate::console as console;
use core::fmt::Write;

pub struct Semaphore {
    spins: bool,
    count: u32,
    max_count: u32,
}

impl Semaphore {
    pub fn new(scount: u32, do_spin: bool) -> Semaphore {
        let s = Semaphore{ spins: do_spin, count: scount, max_count: scount };
        s
    }

    pub fn get(&mut self) -> bool {
        true
    }
        
}

/* A machine-mode mutex structure. Does not support spinning: instead, we
   bounce off if acquisition fails to prevent indefinite hanging. */
pub struct Mutex {
    val: usize,
}

impl Mutex {
    pub fn new() -> Mutex {
        let m = Mutex{ val: 1 };
        m
    }

    /* The meat of the acquisition function. Attempt to acquire the lock by
       setting its value to zero (decrement it, semaphore-style). If that
       fails, bail out. Otherwise, we have the lock. */
    unsafe fn _acquire(&mut self) -> bool {
        let addr = &mut self.val as *mut usize;
        let init: u32 = 1;
        let mut res: u32 = 0;
        /* Wait, so I can use t0 in the asm itself, but I can't use it for
           input and output registers? Jesus Christ... */
        asm!("li t0, 0
              amoswap.w.aq t0, t0, (a0)"    :
             "={x5}"(res)                   :
             "{x10}"(addr)                  :
             "x5"                           :
             "volatile");

        match res {
            0   => false,
            _   => true,
        }
    }

    /* A wrapper around _acquire so we don't need an `unsafe {...}` block
       every time we want to get a lock. */
    pub fn acquire(&mut self) -> bool {
        unsafe { self._acquire() }
    }

    /* Restore the mutex to its unlocked value (1).
       Like with acquire and _acquire, we have the unsafe fn and a safe
       wrapper around it to minimize use of `unsafe{...}` elsewhere. */
    unsafe fn _release(&mut self) {
        let addr = &mut self.val as *mut usize;
        asm!("li t0, 1
              amoswap.w.rl t0, t0, (a0)"    :
              :
              "{x10}"(addr)                 :
              "x5"                          :
              "volatile");
    }

    pub fn release(&mut self) {
        unsafe { self._release(); }
    }

    pub fn spin_acquire(&mut self) {
    }
}
