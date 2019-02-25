/* locks.rs
   Cotains implementations for machine-mode (NO SPINNING) semaphores and
   mutices. */
use crate::console as console;
use core::fmt::Write;

/* The semaphore structure. */
pub struct Semaphore {
    count: u32,
    max_count: u32,
}

impl Semaphore {
    /* Create a new semaphore */
    pub fn new(cnt: u32) -> Semaphore {
        let s = Semaphore{ count: 0, max_count: cnt };
        s
    }

    /* Unsafe acquisition function. Use atomic memory operations to increment
       the semaphore's count. If the count exceeds the max, there's no room
       for this acquisition. Decrement the count (okay, just call release())
       and fail in that case, otherwsie we have obtained the lock. */
    /* Canonically this should be called wait(), but since we're not spinning
       I don't really want to use that term. */
    unsafe fn _acquire(&mut self) -> bool {
        let addr = &mut self.count as *mut u32;
        let one: i32 = 1;
        let mut res: u32 = 0;
        asm!("amoadd.w.aq t0, t0, (a0)"     :
            "={x5}"(res)                    :
            "{x5}"(one), "{x10}"(addr)      :
            "x5", "x10"                     :
            "volatile");

<<<<<<< HEAD
        if res >= self.max_count {
            self.release();
            return false;
=======
        match res {
            0   => false,
            _   => true
>>>>>>> dbc84bb45d874f2463b153ddc1b5b1c25bad5714
        }

        true
    }

    /* A safe wrapper around the unsafe function above. This isn't really
       needed, but it minimizes the need to use `unsafe{...}` elsewhere. */
    pub fn acquire(&mut self) -> bool {
        let rv: bool;
        unsafe {
            rv = self._acquire();
        }

        rv
    }

    /* Release one holder of the semaphore. This uses atomic memory ops to
       decrement the semaphore's count, increasing the number of available
       slots by one (or restoring it to the pre-attempt value if this is
       called in the failure branch of `acquire()`. */
    unsafe fn _release(&mut self) {
        let addr = &mut self.count as *mut u32;
        let one: i32 = 1;
        let neg_one: i32 = -1;
        let mut res: i32;
        asm!("amoadd.w.rl t0, t0, (a0)"     :
             "={x5}"(res)                   :
             "{x5}"(neg_one), "{x10}"(addr) :
             "x5", "x10"                    :
             "volatile");

        /* Technically, you should never explicitly release a lock you don't
           hold. However, since `release()` is a public function, people can
           do it, and you know they will. The following code protects against
           that by re-incrementing the lock variable if it goes out of bounds
           on a release. */
        if res <= 0 {
            asm!("amoadd.w.aqrl t0, t0, (a0)"   :
                 :
                 "{x5}"(one), "{x10}"(addr)     :
                 "x5", "x10"                    :
                 "volatile");
        }
    }

    /* Safe wrapper around above function */
    pub fn release(&mut self) {
        unsafe { self._release(); }
    }
}

/* A mutex, which I'm simplifying by just hard-coding a Semaphore with a count
   of one. */
pub struct Mutex {
    s: Semaphore,
}

impl Mutex {
    pub fn new() -> Mutex {
        let sem = Semaphore::new(1);
        let m = Mutex{ s: sem };
        m
    }

<<<<<<< HEAD
    /* Thanks to the use of a Semaphore, we don't need to use any unsafe ops
       directly here and can just wrap our acquire and release functions
       around the Semaphore's equivalents. There may be some call overhead
       due to this, but I'll let the optimizer deal with that. */
=======
    /* The basic premise of both of these functions is the same. Acquire the
       count lock, modify the Semaphore's count, then release the count lock.  The only potential
       weirdness is that a multithreaded system could actually fail to release a Semaphore. I
       think, even in machine mode, it might be appropriate to spin on release since any Mutex
       acquisition here is really tight. In a single-threaded system, I highly doubt it could make
       any real difference. */
>>>>>>> dbc84bb45d874f2463b153ddc1b5b1c25bad5714
    pub fn acquire(&mut self) -> bool {
        self.s.acquire()
    }

<<<<<<< HEAD
    pub fn release(&mut self) {
        self.s.release();
=======
    pub fn release(&mut self) -> bool {
        if self.cnt_lock.acquire() == false {
            return false;
        }

        if self.cnt < self.max_cnt {
            self.cnt += 1;
        }

        self.cnt_lock.release();
        true
>>>>>>> dbc84bb45d874f2463b153ddc1b5b1c25bad5714
    }
}
