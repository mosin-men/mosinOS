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
    pub static __heap_size: u16;
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
        let heap_size: u16 = &__heap_size as *const _ as u16;
        println!("Heap size: {}", heap_size);
        let mem: *mut FreeNode = &mut __heap_start as *mut FreeNode;
        let node = FreeNode {
            taken: 0,
            size: heap_size
        };
        println!("Initializing heap at {:p}, size: {:p}", mem, &__heap_size);
        mem.offset(0).write(node);
    }
}

/* Returns either:
 *   1. A pointer to a 4-byte-aligned region of memory at least as large as you requested.
 *   2. A NULL pointer, if the heap has no room.
 */
pub fn kmalloc(mut size: u16) -> *mut u16 {
    /* No allocation if no size */
    if size == 0 {
        return 0 as *mut u16;
    }

    /* Get size to be a multiple of 4 */
    let rem: u16 = size % 4;
    if rem != 0 {
        size = size + (4 - rem);
    }

    unsafe {
        /* Pointer to the start of our heap. */
        let start: *mut FreeNode = &mut __heap_start as *mut FreeNode;
        /* Used to offset the above pointer into the heap */
        let mut offset: isize = 0;
        /* Pointer to the end of the heap */
        let end: *mut FreeNode = &mut __heap_end as *mut FreeNode;
        let blocksize: u16;

        /* Loop until we find a free block that's big enough */
        loop {
            println!("Looking at a FreeNode: {} {}", start.offset(offset).read().taken, start.offset(offset).read().size);
            if start.offset(offset) >= end {
                /* We've hit the end of the heap */
                println!("Failed to allocate.");
                return 0 as *mut u16;
            }
            if (start.offset(offset).read().taken == 0) && (start.offset(offset).read().size >= size) {
                /* We found a block that's:
                 *   1. Not taken
                 *   2. Large enough
                 */
                println!("Found: {} {}", start.offset(offset).read().taken, start.offset(offset).read().size);
                break;
            }
            offset += ((start.offset(offset).read().size as isize) / 4) + 1;
        }

        /* The size of the block that we've chosen to take from */
        blocksize = start.offset(offset).read().size;

        /* If there will only be 4 bytes left, just give it away */
        if blocksize == (size + 4) {
            size += 4;
        }
        
        /* Initialize the next block in the freelist, before the current block is overwritten. */
        /* Only do this if we're not consuming the entire block. */
        if(blocksize > size) {
            let nextnode = FreeNode {
                taken: 0,
                size: blocksize - size
            };
            start.offset(offset + ((size / 4) as isize) + 1).write(nextnode);
        }

        /* We write this into memory to do the allocation */
        let node = FreeNode {
            taken: 1,
            size: size
        };
        start.offset(offset).write(node);

        /* Return the pointer to the allocation */
        println!("Allocation succeeding at {:p} for {} bytes.", start.offset(offset + 1) as *mut u16, size);
        start.offset(offset + 1) as *mut u16
    }
}

/* Frees the pointer that you give it. */
pub fn kfree(ptr: *mut u16) -> () {
    unsafe {
        /* Pointer to the start of our heap. */
        let start: *mut FreeNode = &mut __heap_start as *mut FreeNode;
        /* Used to offset the above pointer into the heap */
        let mut offset: isize = 0;
        /* Pointer to the end of the heap */
        let end: *mut FreeNode = &mut __heap_end as *mut FreeNode;

        /* Sanity checks */
        if (ptr < (start as *mut u16)) || (ptr > (end as *mut u16)) {
            println!("Pointer was invalid: {:p}", ptr);
        }

        /* We'll write this to memory to free up a block */
        println!("Freeing allocation which was for {} bytes.", (ptr as *mut FreeNode).offset(-1).read().size);
        let node = FreeNode {
            taken: 0,
            size: (ptr as *mut FreeNode).offset(-1).read().size
        };
        (ptr as *mut FreeNode).offset(-1).write(node);
    }
}
