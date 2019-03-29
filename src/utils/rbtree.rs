/*
 * rbtree.rs
 *
 * Generic red-black tree implementation.
 * Supports insertion, deletion, and lookup.
 * Keeps track of node with lowest key for constant
 * time priority functionality.
 */

use crate::mem::heap::{*};
use core::fmt::Write;
use crate::console;
use core::mem::{size_of, zeroed};
use core::ptr::null;
use core::ops::Not;

macro_rules! not {
    ($b:expr) => ((!($b as u32)) & 0x1)
}

macro_rules! alloc {
    ($T:ty) => (kmalloc(core::mem::size_of::<$T>() as u32) as *mut $T)
}

macro_rules! free {
    ($ptr:expr) => (kfree($ptr as *const _ as *mut u32))
}

macro_rules! child {
    ($obj:expr, $idx:expr) => ($obj.children[$idx as usize])
}

macro_rules! NULL {
    ($T:ty) => (core::ptr::null::<$T>() as *mut $T)
}

pub struct rbtree_node<K_T : Clone + PartialOrd + core::fmt::Debug, V_T : Clone + core::fmt::Debug> {
    red      : bool,
    children : [ *mut Self; 2],
    parent   : *mut Self,
    key      : K_T,
    val      : V_T
}

impl <K_T : Clone + PartialOrd + core::fmt::Debug, V_T : Clone + core::fmt::Debug> rbtree_node<K_T, V_T> {
    unsafe fn print(&self, lvl : u32) {
        if !child!(self, 1).is_null() {
            (*child!(self, 1)).print(lvl + 1);
        }

        for i in 0..(2 * lvl) { print!(" "); }
        if self.parent.is_null() {
            println!("{:?} = {:?}",
                    self.key,
                    self.val);
        } else {
            println!("{:?}({:?}) = {:?}",
                    self.key,
                    (*self.parent).key,
                    self.val);
        }

        if !child!(self, 0).is_null() {
            (*child!(self, 0)).print(lvl + 1);
        }
    }

    unsafe fn new(key : &K_T, val : &V_T) -> *mut Self {
        let ptr  = alloc!(Self);
        let node = &mut *ptr;

        node.red        = true;
        child!(node, 0) = NULL!(Self);
        child!(node, 1) = NULL!(Self);
        node.parent     = NULL!(Self);
        node.key        = key.clone();
        node.val        = val.clone();

        return ptr;
    }

    unsafe fn dispose(&mut self) {
        if !self.children[0].is_null() {
            (&mut *self.children[0]).dispose();
            free!(self.children[0]);
        }
        if !self.children[1].is_null() {
            (&mut *self.children[1]).dispose();
            free!(self.children[1]);
        }
    }

    unsafe fn rotate(&mut self, dir : u32) -> *mut Self {
        let result_ptr = child!(self, not!(dir));
        let result     = &mut *result_ptr;

        child!(self, not!(dir)) = child!(result, dir);
        if !child!(self, not!(dir)).is_null() {
            (*child!(self, not!(dir))).parent = self;
        }
        child!(result, dir) = self;
        if !child!(result, dir).is_null() {
            (*child!(result, dir)).parent = result;
        }
        self.red   = true;
        result.red = false;

        return result_ptr;
    }
    
    unsafe fn rotate2(&mut self, dir : u32) -> *mut Self {
        if !child!(self, not!(dir)).is_null() {
            child!(self, not!(dir)) = (*child!(self, not!(dir))).rotate(not!(dir));
            if !child!(self, not!(dir)).is_null() {
                (*child!(self, not!(dir))).parent = self;
            }
        }
        return self.rotate(dir);
    }
}

pub struct rbtree<K_T : Clone + PartialOrd + core::fmt::Debug, V_T : Clone + core::fmt::Debug> {
    root : *mut rbtree_node<K_T, V_T>,
    beg  : *mut rbtree_node<K_T, V_T>,
    pub len  : usize
}

impl <K_T : Clone + PartialOrd + core::fmt::Debug, V_T : Clone + core::fmt::Debug> rbtree<K_T, V_T> {
    pub fn new() -> Self {
        rbtree {
            root : NULL!(rbtree_node<K_T, V_T>),
            beg  : NULL!(rbtree_node<K_T, V_T>),
            len  : 0
        }
    }

    pub fn dispose(&mut self) {
        unsafe {
            if !self.root.is_null() {
                (*self.root).dispose();
                free!(self.root);
                self.beg = NULL!(rbtree_node<K_T, V_T>);
                self.len = 0;
            }
        }
    }

    pub fn print(&self) {
        unsafe {
            println!("------------------ TREE ({} nodes) ------------------", self.len);
            if !self.root.is_null() {
                (*self.root).print(0);
            }
            println!("-----------------------------------------------------");
        }
    }

    pub fn insert(&mut self, key : K_T, val : V_T) {
        unsafe {
            let mut node       = NULL!(rbtree_node<K_T, V_T>);
            let mut made_new   = false;
            let mut only_lefts = true;

            if self.root.is_null() {
                self.root = rbtree_node::new(&key, &val);
                self.beg  = self.root;
                node      = self.root;
                made_new  = true;
            } else {
                let mut head : rbtree_node<K_T, V_T> = core::mem::zeroed(); /* False tree root */

                let mut g = NULL!(rbtree_node<K_T, V_T>);            /* Grandparent */
                let mut h = &mut head as *mut rbtree_node<K_T, V_T>; /* Parent */
                let mut p = NULL!(rbtree_node<K_T, V_T>);            /* Iterator*/
                let mut q = self.root;                               /* Parent*/

                child!(*h, 1) = self.root;
                let mut dir   = 0u32;
                let mut last  = 0u32;

                loop {
                    if q.is_null() {
                        /* Insert node at the first null link */
                        q = rbtree_node::new(&key, &val);
                        child!(*p, dir) = q;
                        (*q).parent     = p;
                        made_new        = true;
                    } else if (*child!(*q, 0)).red && (*child!(*q, 1)).red {
                        /* Simple red violation: color flip */
                        (*q).red             = true;
                        (*child!(*q, 0)).red = false;
                        (*child!(*q, 1)).red = false;
                    }

                    if (*q).red && (*p).red {
                        /* Hard red violation: rotations necessary */
                        let dir2 = (child!(*h, 1) == g) as u32;
                        if q == child!(*p, last) {
                            child!(*h, dir2) = if g.is_null() {
                                NULL!(rbtree_node<K_T, V_T>)
                            } else {
                                (*g).rotate(not!(last))
                            }
                        } else {
                            child!(*h, dir2) = if g.is_null() {
                                NULL!(rbtree_node<K_T, V_T>)
                            } else {
                                (*g).rotate2(not!(last))
                            }
                        }

                        if !child!(*h, dir2).is_null() {
                            (*child!(*h, dir2)).parent = h;
                        }
                    }

                    /* Stop working if we inserted a node. This
                     * check also disallows duplicates in the tree. */
                    if key == (*q).key {
                        if !made_new {
                            (*q).val = val.clone();
                        }
                        node = q;
                        break;
                    }

                    last        = dir;
                    dir         = (((*q).key < key) as u32);
                    only_lefts &= not!(dir) != 0;

                    /* Move the helpers down */
                    if !g.is_null() { h = g; }
                    g = p;
                    p = q;
                    q = child!(*q, dir);
                }

                /* Update the root (it may be different) */
                self.root = child!(head, 1);
                if !self.root.is_null() {
                    (*self.root).parent = NULL!(rbtree_node<K_T, V_T>);
                }
            }

            (*self.root).red = false;
            if made_new {
                self.len += 1;
                if only_lefts {
                    self.beg = node;
                }
            }
        }
    }
    
    pub fn lookup(&mut self, key : K_T) -> Option<(&mut K_T, &mut V_T)> {
        unsafe {
            let mut node = self.root;

            while !node.is_null() {
                if (*node).key == key {
                    break;
                } else {
                    let dir = ((*node).key < key) as u32;
                    node = child!(*node, dir);
                }
            }

            return if node.is_null() {
                None
            } else {
                Some((&mut (*node).key, &mut (*node).val))
            }
        }
    }

    pub fn delete(&mut self, key : K_T) -> bool {
        unsafe {
            if self.root.is_null() { return false; }

            if self.len == 1 && (*self.root).key == key {
                free!(self.root);
                self.root = NULL!(rbtree_node<K_T, V_T>);
                self.beg  = NULL!(rbtree_node<K_T, V_T>);
                self.len  = 0;
                return true;
            }

            let mut head : rbtree_node<K_T, V_T> = core::mem::zeroed(); /* False tree root */

            /* Helpers */
            let mut q = &mut head as *mut rbtree_node<K_T, V_T>;
            let mut p = NULL!(rbtree_node<K_T, V_T>);
            let mut g = NULL!(rbtree_node<K_T, V_T>);
            let mut f = NULL!(rbtree_node<K_T, V_T>);

            child!(*q, 1) = self.root;

            let mut dir = 1;

            /* Search and push a red node down
             * to fix red violations as we go. */
            while !child!(*q, dir).is_null() {
                let mut last = dir;

                /* Move the helpers down. */
                g = p;
                p = q;
                q = child!(*q, dir);

                dir = ((*q).key < key) as u32;

                /* Save the node with matching value and keep
                 * going; we'll do removal tasks at the end. */
                if (*q).key == key {
                    f = q;
                }

                /* Push the red node down with rotations and color flips. */
                if !(*q).red && !(*child!(*q, dir)).red {
                    if (*child!(*q, not!(dir))).red {
                        child!(*p, last) = (*q).rotate(dir);
                        if !child!(*p, last).is_null() {
                            (*child!(*p, last)).parent = p;
                        }
                        p = child!(*p, last);
                    } else {
                        let s = child!(*p, not!(last));
                        if !s.is_null() {
                            if !(*child!(*s, last)).red && !(*child!(*s, not!(last))).red {
                                /* Color flip */
                                (*p).red = false;
                                (*s).red = true;
                                (*q).red = true;
                            } else {
                                let dir2 = (child!(*g, 1) == p) as u32;
                                if (*child!(*s, last)).red {
                                    child!(*g, dir2) = (*p).rotate2(last);
                                } else if (*child!(*s, not!(last))).red  {
                                    child!(*g, dir2) = (*p).rotate(last);
                                }
                                if !child!(*g, dir2).is_null() {
                                    (*child!(*g, dir2)).parent = g;
                                }

                                /* Ensure correct coloring */
                                (*q).red                            = true;
                                (*child!(*g, dir2)).red             = true;
                                (*child!(*child!(*g, dir2), 0)).red = false;
                                (*child!(*child!(*g, dir2), 1)).red = false;
                            }
                        }
                    }
                }
            }

            /* Replace and remove the saved node. */
            if !f.is_null() {
                let tmp_k = (*f).key.clone();
                let tmp_v = (*f).val.clone();
                (*f).key  = (*q).key.clone();
                (*f).val  = (*q).val.clone();
                (*q).key  = tmp_k;
                (*q).val  = tmp_v;

                child!(*p, (child!(*p, 1) == q) as u32)
                    = child!(*q, (child!(*q, 0).is_null() as u32));

                if !child!(*p, (child!(*p, 1) == q) as u32).is_null() {
                    (*child!(*p, (child!(*p, 1) == q) as u32)).parent = p;
                }

                if q == self.beg {
                    self.beg = p;
                }

                free!(q);

                q = NULL!(rbtree_node<K_T, V_T>);
            }

            /* Update the root (it may be different) */
            self.root           = child!(head, 1);
            (*self.root).parent = NULL!(rbtree_node<K_T, V_T>);

            /* Make the root black for simplified logic */
            if !self.root.is_null() {
                (*self.root).red = false;
            }

            if f.is_null() { return false; }

            self.len -= 1;

            return true;
        }
    }

    pub fn first(&self) -> Option<(&mut K_T, &mut V_T)> {
        unsafe {
            if self.beg.is_null() {
                None
            } else {
                Some((&mut (*self.beg).key, &mut (*self.beg).val))
            }
        }
    }
}
