/* locks.rs
   Cotains implementations for machine-mode (NO SPINNING) semaphores and
   mutices. */
use crate::console as console;
use core::fmt::Write;

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
        println!("Acquire addr = 0x{:X}", addr as u32);
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
            _   => true
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
        println!("Release addr = 0x{:X}", addr as u32);
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
}

/* The machine-mode (NO SPINNING) semaphore. I know technically the Mutex
   should be a type of Semaphore, but making the Semaphore distinct allows its
   count to be protected by a Mutex, which removes some potential sources of
   race conditions. So, if you need a binary Semaphore, use Mutex instead as
   it has less overhead associated with it. */
pub struct Semaphore {
    cnt: u32,
    max_cnt: u32,
    cnt_lock: Mutex,
}

impl Semaphore {
    /* Create a new Semaphore. Which, of course, has its own Mutex. */
    pub fn new(in_cnt: u32) -> Semaphore {
        let m = Mutex::new();
        let s = Semaphore{cnt: in_cnt, max_cnt: in_cnt, cnt_lock: m};
        s
    }

    /* The basic premise of both of these functions is the same. Acquire the
       count lock, modify the Semaphore's count, then release the count lock.  The only potential
       weirdness is that a multithreaded system could actually fail to release a Semaphore. I
       think, even in machine mode, it might be appropriate to spin on release since any Mutex
       acquisition here is really tight. In a single-threaded system, I highly doubt it could make
       any real difference. */
    pub fn acquire(&mut self) -> bool {
        if self.cnt_lock.acquire() == false {
            return false;
        }

        if self.cnt == 0 {
            self.cnt_lock.release();
            return false;
        }

        self.cnt -= 1;
        self.cnt_lock.release();

        true
    }

    pub fn release(&mut self) -> bool {
        if self.cnt_lock.acquire() == false {
            return false;
        }

        if self.cnt < self.max_cnt {
            self.cnt += 1;
        }

        self.cnt_lock.release();
        true
    }
}
