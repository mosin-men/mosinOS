/* The heap.
 * This is how the kernel allocates memory to the heap.
 * All process stacks are stored on this heap, as well
 * as user heap allocations.
 * This heap should consume the majority of RAM. The
 * kernel's stack consumes 2K, and this heap should
 * consume the remainder of the machine's 16K.
 * Its mechanisms are simple: initialize by
 * creating a 4-byte header that will serve as the first
 * node in the freelist, and each time an allocation
 * is made, iterate over the freelist and find the first
 * free block of memory.
 * Fails only when it cannot make the requested allocation.
 */
use crate::console as console;
use core::fmt::Write;

/* These come from the linker script */
extern "C" {
    pub static mut __heap_start: FreeNode;
    pub static mut __heap_end: FreeNode;
    pub static __heap_size: u32;
}

/* Freelist header. Needs to be 4 bytes (to keep the heap aligned properly).  We could make this a
 * smaller value, and align the heap another way. */
#[repr(C)]
struct FreeNode {
    taken: u16, /* 0 means not taken, any other value means taken */
    size: u16 /* size in bytes */
}

/* Initialize the heap by simply creating a single free node at the beginning of the heap, which is
 * at `__heap_start`. */
pub fn heap_init() -> () {
    unsafe {
        let mem: *mut FreeNode = &mut __heap_start as *mut FreeNode;
        let node = FreeNode {
            taken: 0,
            size: 0
        };
        println!("Initializing heap at {:p}, size: {:p}", mem, &__heap_size);
        mem.offset(0).write(node);
    }
}

pub fn allocate(size: u16) -> *mut u16 {
    unsafe {
        /* Get size to be a multiple of 4 */
        /* TODO */

        let mem: *mut FreeNode = &mut __heap_start as *mut FreeNode; /* Pointer into memory we're using for the heap */
        let mut offset: isize = 0; /* Offsets into the heap */
        let end: *mut FreeNode = &mut __heap_end as *mut FreeNode; /* Used to check if we've reached the end of the heap */
        let node = FreeNode {
            taken: 1,
            size: size
        };

        /* Loop until we find a free block */
        while (mem.offset(offset).read().taken != 0) && (mem.offset(offset) < end) {
            offset += ((mem.offset(offset).read().size as isize) / 4) + 1;
        }

        if mem.offset(offset) >= end {
            return 0 as *mut u16;
        }

        let diff: u16 = (end as u16) - (mem.offset(offset) as u16);
        if ((size) + 4) > diff {
            return 0 as *mut u16;
        }

        /* We found a free block. Mark it as taken. */
        mem.offset(offset).write(node);
        mem.offset(offset + 1) as *mut u16
    }
}
