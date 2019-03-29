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
 * Frees memory by coallescing. It does this by
 * first freeing up the block that was requested, and then
 * looking one block up and down to see if they need to be
 * merged. This prevents fragmentation.
 */
use crate::console as console;
use core::fmt::Write;

/* These come from the linker script */
extern "C" {
    pub static mut __heap_start: u32;
    pub static mut __heap_end: u32;
    pub static __heap_size: u32;
}

/* Masks to pack a freelist header into 32 bits.
 * The layout looks like:
 *
 * uppppppp pppppppp tccccccc cccccccc
 * 00000000 00000001 00001101 11011101
 *
 * t = taken bit
 * u = unused, reserved for future
 * p = size in words of previous allocation
 * c = size in words of current allocation
 *
 * The maximum size of an allocation with this
 * layout is (2^15)*4 = 131,072 bytes.
 */
const taken_mask: u32 = 0x00008000;
const cur_size_mask: u32 = 0x00007FFF;
const prev_size_mask: u32 = 0x7FFF0000;
const max_block_size: u32 = (1 << 15) * 4;

/* Initialize the heap by simply creating a single free node at the beginning of the heap,
 * which is at __heap_start.
 */
pub fn heap_init() -> () {
    unsafe {
        let heap_size: u32 = &__heap_size as *const _ as u32;
        let ptr: *mut u32 = &mut __heap_start as *mut u32; /* Pointer to the start of the heap */

        /* Take 4 bytes from the size of the heap, that's this node in the freelist.
         * Also divide by 4 since the size that we store is the number of words.
         */
        let node: u32 = cur_size_mask & (((heap_size - 4) / 4) as u32);
        ptr.write(node);

        // println!("Initializing heap at {:p}, size: {:p}", ptr, &__heap_size);
    }
}

/* Returns either:
 *   1. A pointer to a 4-byte-aligned region of memory at least as large as you requested.
 *   2. A NULL pointer, if the heap has no room.
 */
pub fn kmalloc(mut size: u32) -> *mut u32 {
    /* Check the size to make sure it's not too big or zero */
    if (size == 0) || (size > max_block_size) {
        return 0 as *mut u32;
    }

    /* Get size to be a multiple of 4,
     * then divide it by 4.
     */
    let rem: u32 = size % 4;
    if rem != 0 {
        size = size + (4 - rem);
    }
    size /= 4;

    unsafe {
        /* Pointer to the start of our heap. */
        let start: *mut u32 = &mut __heap_start as *mut u32;
        /* Used to offset the above pointer into the heap */
        let mut offset: isize = 0;
        /* Pointer to the end of the heap */
        let end: *mut u32 = &mut __heap_end as *mut u32;
        let blocksize: u32;
        let prevsize: u32;
        let mut node: u32;

        /* Loop until we find a free block that's big enough */
        loop {
            node = start.offset(offset).read();
            if start.offset(offset) >= end {
                /* We've hit the end of the heap */
                return 0 as *mut u32;
            }
            if ((node & taken_mask) == 0) && ((node & cur_size_mask) >= size) {
                /* We found a block that's:
                 *   1. Not taken
                 *   2. Large enough
                 */
                break;
            }

            /* Move on to the next node in the freelist.
             * Adding one to the offsets moves the "pointer" 4 bytes.
             * */
            offset += ((node & cur_size_mask) as isize) + 1;
        }

        /* The size of the block that we've chosen to take from, divided by 4 bytes */
        blocksize = node & cur_size_mask;
        prevsize = node & prev_size_mask;

        /* If there will only be 4 bytes left, just give it away */
        if blocksize == (size + 1) {
            size += 1;
        }
        
        if(blocksize > size) {
            /* Split the block that we've chosen to take from. Only do this if we're
             * not consuming the entire block. Since this block is the block after
             * the one that we're currently allocating, its "previous size" will
             * be the size of the current allocation. It's size will be the
             * size of the block minus what we're about to take from it to do
             * the current allocation.
             */
            let nextnode: u32 = (((blocksize - size - 1) as u32) & cur_size_mask) |
                                (((size as u32) << 16) & prev_size_mask);
            start.offset(offset + (size as isize) + 1).write(nextnode);
        }

        /* We write this into memory to do the allocation */
        node = taken_mask | 
               ((size as u32) & cur_size_mask) |
               ((prevsize as u32) & prev_size_mask);
        start.offset(offset).write(node);

        /* Return the pointer to the allocation */
        start.offset(offset + 1) as *mut u32
    }
}

pub fn heap_print(max_offset: isize) -> () {
    unsafe {
        let start: *mut u32 = &mut __heap_start as *mut u32;
        let mut offset: isize = 0;
        let end: *mut u32 = &mut __heap_end as *mut u32;
        let mut node: u32;

        /* Print the whole heap. */
        println!("===== HEAP =====");
        loop {
            node = start.offset(offset).read();
            if (start.offset(offset) >= end) || (offset >= max_offset) {
                break;
            }
            println!("{:032b}", node);
            offset += 1;
        }
        println!("===== HEAP =====");
    }
}

/* Frees the pointer that you give it. */
pub fn kfree(arg_ptr: *mut u32) -> () {
    unsafe {
        let start: *mut u32;
        let end: *mut u32;
        let mut node: u32;
        let mut prevnode: u32;
        let nextnode: u32;
        let mut offset: isize;
        let mut ptr: *mut u32;
        let mut size: u32;
        let prevsize: u32;

        ptr = arg_ptr;
        start = &mut __heap_start as *mut u32;
        end = &mut __heap_end as *mut u32;

        /* Sanity checks */
        if (ptr < (start as *mut u32)) || (ptr >= (end as *mut u32)) {
            println!("ERROR: Pointer was invalid: {:p}", ptr);
            return;
        }

        /* Grab the node in the freelist that's going to be freed.
         * Go ahead and free it by usetting the "taken" bit.
         */
        ptr = ptr.offset(-1);
        node = ptr.read();
        node &= !taken_mask;
        ptr.write(node);

        /* Save the information in the node */
        size = node & cur_size_mask;
        prevsize = (node & prev_size_mask) >> 16;

        /* Look down to see if we need to merge the block below. */
        offset = (size + 1) as isize;
        if ptr.offset(offset) < end {
            nextnode = ptr.offset(offset).read();
            if (nextnode & taken_mask) == 0 {
                /* If the next node isn't taken, merge. Use the stored size
                 * since we're clearing it out in memory.
                 */
                node &= !cur_size_mask;
                size = (nextnode & cur_size_mask) + size + 1;
                node |= size & cur_size_mask;
                ptr.write(node);
            }
        }


        /* Look up to see if we need to merge the block above. */
        offset = (prevsize + 1) as isize;
        if prevsize != 0 {
            prevnode = ptr.offset(offset.wrapping_neg()).read();
            // println!("Prevsize: {}", prevsize);
            // println!("Offset: {}", offset);
            // println!("Offset: {}", offset.wrapping_neg());
            // println!("Prevnode: {:032b}", prevnode);
            if (prevnode & taken_mask) == 0 {
                /* If the previous node isn't taken, merge. */
                prevnode &= !cur_size_mask;
                prevnode |= (prevsize + size + 1) & cur_size_mask;
                ptr.offset(offset.wrapping_neg()).write(prevnode);
            }
        }
    }
}
