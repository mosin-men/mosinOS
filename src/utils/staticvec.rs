/* The stackvec macro with arms for storage only and 
 *      storage with list of items to push */

use core::iter::Iterator;
use core::ops::IndexMut;
use core::ops::Index;

macro_rules! stackvec {
    ($storage:expr) => (
        {
            let ret = StackVec::new($storage);
            ret
        }
    );

    ($storage:expr, $($x:expr),*) => (
        {
            let mut ret = StackVec::new($storage);
            $(
                /*Might need some error handling here*/
                let rv = ret.push($x);
                rv.expect("Not enough storage for all elements to push in macro");

            )*
            ret
        }
    );
}

/* The StackVec structure with its two member variables. */
struct StackVec<'a, T: 'a> {
    buffer: &'a mut [T],
    size: usize,
}

/* Functions for the StackVec structure. */
impl<'a, T> StackVec<'a, T> {
    /* Create a new StackVec from a supplied array. This is a static method. */
    fn new(storage: &'a mut [T]) -> StackVec<'a, T> {
        let s = StackVec {buffer: storage, size: 0};
        s
    }

    /* Get the USED size of the vector */
    fn size(&self) -> usize {
        self.size
    }

    /* Get the MAX size of the vector */
    fn buffer_size(&self) -> usize {
        self.buffer.len()
    }

    /* Push an object to the rear of the vector. Fail and return Err if
       capacity has been reached, otherwise add data and increment used 
       size. */
    fn push(&mut self, data: T) -> Result<(), ()> {
        let sz = self.size;
        let max_sz = self.buffer_size();

        if sz == max_sz {
            return Err(());
        }
            
        self.buffer[sz] = data;
        self.size += 1;
        Ok(())
    }

    /* Get the data stored at the tail of the vector. Fail and return Err if
       vector is empty. Otherwise, return a mutable reference to the data in
       question and decrement the used size. */
    fn pop(&mut self) -> Result<&mut T, ()> {
        if self.size == 0 {
            return Err(());
        }
            
        self.size -= 1;
        Ok(&mut self.buffer[self.size])
    }

    fn iter(&'a self) -> StackVecIterator<'a, T> {
        StackVecIterator{ vector: self, location: 0 }
    }
}

struct StackVecIterator<'a, T: 'a> {
    vector: &'a StackVec<'a, T>, //The vector to iterate across.
    location: usize, //The element the iterator is currently on.
}

impl <'a, T: 'a> Iterator for StackVecIterator<'a, T> {
    type Item = &'a T;

    fn next(&mut self) -> Option<&'a T> {
        if self.location >= self.vector.size {
            None
        } else {
            self.location += 1;
            Some(& self.vector.buffer[self.location - 1])
        }
    }
}

/* Indexers for the StackVec. Should be pretty self-explanatory.
   Except for the second lifetime, that is. */
impl<'a, T> Index<usize> for StackVec<'a, T> {
    type Output = T;

    fn index<'b>(&'b self, index: usize) -> &'b T {
        &self.buffer[index]
    }
}

impl<'a, T> IndexMut<usize> for StackVec<'a, T> {
    fn index_mut<'b>(&'b mut self, index: usize) -> &'b mut T {
        &mut self.buffer[index]
    }
}
