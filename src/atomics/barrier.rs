/* The barrier structure, used for ordering. When a barrier is created, you're 
   expecting <n> processes to wait at the barrier. They'll have to sleep or
   spin or whatever, but that's what it's for. */
struct Barrier {
    total: u32,
    count: u32,
}

impl Barrier {
    pub fn new(cnt: u32) -> Barrier {
        let b = Barrier { total: 0, count: cnt };
        b
    }

    unsafe fn _wait(&mut self) {
        asm!("fence");
        self.total += 1;
    }

    pub fn wait(&mut self) {
        unsafe { self._wait(); }
        /* Process will actually sleep here, when we have them. */
    }

    unsafe fn _check(&self) -> bool {
        asm!("fence");
        if self.count == self.total {
            return true;
        }
        else {
            return false;
        }
    }

    pub fn check(&self) -> bool {
        let rv: bool;
        unsafe {
            rv = self._check();
        }

        rv
    }
}
