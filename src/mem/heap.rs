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
pub struct FreeNode {
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

pub fn allocate(mut size: u16) -> *mut u16 {
    unsafe {
        /* No allocation if no size */
        if size == 0 {
            return 0 as *mut u16;
        }

        /* Get size to be a multiple of 4 */
        let rem: u16 = size % 4;
        if rem != 0 {
            size = size + (4 - rem);
        }

        /* Pointer to the start of our heap. */
        let mem: *mut FreeNode = &mut __heap_start as *mut FreeNode;
        /* Used to offset the above pointer into the heap */
        let mut offset: isize = 0;
        /* Pointer to the end of the heap */
        let end: *mut FreeNode = &mut __heap_end as *mut FreeNode;
        /* We write this into memory to do the allocation */
        let node = FreeNode {
            taken: 1,
            size: size
        };

        /* Loop until we find a free block */
        while (mem.offset(offset).read().taken != 0) && (mem.offset(offset) < end) {
            offset += ((mem.offset(offset).read().size as isize) / 4) + 1;
        }

        /* Return NULL if we're at the end of the heap */
        if mem.offset(offset) >= end {
            return 0 as *mut u16;
        }

        /* Return NULL if we don't have enough bytes to fulfill the allocation */
        let diff: u16 = (end as u16) - (mem.offset(offset) as u16);
        if ((size) + 4) > diff {
            return 0 as *mut u16;
        }

        /* Grab the allocation */
        mem.offset(offset).write(node);

        /* Return the pointer to the allocation */
        mem.offset(offset + 1) as *mut u16
    }
}
