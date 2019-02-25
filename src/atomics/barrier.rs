struct Barrier {
}

impl Barrier {
    unsafe fn _fence() {
        asm!("fence");
    }

    fn fence() {
        unsafe { Barrier::_fence(); }
    }
}
