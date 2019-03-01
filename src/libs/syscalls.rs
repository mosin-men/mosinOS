
pub fn exit(code: u32) {
    _exit(1, code);
}

pub fn alloc(size: u32) {
    _alloc(4, size);
}

pub fn free(addr: u32) {
    _free(5, addr);
}


fn _exit(syscode: u32, code: u32){
    unsafe{
        asm!("ecall");
    }
}

fn _alloc(syscode: u32, size: u32){
    unsafe{
        asm!("ecall");
    }
}

fn _free(syscode: u32, addr: u32){
    unsafe {
        asm!("ecall");
    }
}


