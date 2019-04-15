/* Basic driver for an ext2 file system. */

/* The spec I'm going off of can be found here:
   https://www.nongnu.org/ext2-doc/ext2.html

   We're NOT using the expanded superblock. */

/* Define the superblock, since we really need this. It's 1024 bytes and needs
   to start at byte 1024 of an MBR disk. Most of this will be unused for this 
   assignment, but it has all needed future expandability. */
use crate::console as console;
use core::fmt::Write;

extern "C" {
    pub static mut __fs_start: u32;
}

#[repr(C)]
struct SuperBlock {
    inodes_cnt: u32,
    blocks_cnt: u32,
    r_blocks_cnt: u32,
    f_blocks_cnt: u32,
    f_inodes_cnt: u32,
    first_data_block: u32,
    log_block_size: u32,
    log_frag_size: u32,
    blocks_per_group: u32,
    frags_per_group: u32,
    inodes_per_group: u32,
    mtime: u32,
    wtime: u32,
    mnt_count: u16,
    max_mnt_count: u16,
    magic: u16,
    state: u16,
    errors: u16,
    minor_rev_level: u16,
    lastcheck: u32,
    check_interval: u32,
    creator_os: u32,
    rev_level: u32,
    def_resuid: u16,
    def_resgid: u16,
    first_inode: u32,
    inode_size: u16,
    block_group_number: u16,
    feature_compat: u32,
    feature_incompat: u32,
    feature_ro_compat: u32,
    uuid: u128,
    volume_name: u128,
    /* Look, the next thing here is 512 bytes. There's no u512. Our OS doesn't
       really need it. I'm stopping here. */
}

/* What a mouthful. */
#[repr(C)]
struct BlockGroupDescriptorTbl {
    block_bitmap: u32,
    inode_bitmap: u32,
    inode_table: u32,
    free_blocks_cnt: u16,
    free_inodes_cnt: u16,
    used_dirs_cnt: u16,
    pad: [u8; 14],
}

#[repr(C)]
struct Inode {
    mode: u16,
    uid: u16,
    size: u32,
    atime: u32,
    ctime: u32,
    mtime: u32,
    dtime: u32,
    gid: u16,
    links_count: u16,
    blocks: u32,
    flags: u32,
    osd1: u32,
    block: [u32; 15],
    generation: u32,
    file_acl: u32,
    dir_acl: u32,
    faddr: u32,
    osd2: [u32; 3],
}

#[repr(C)]
struct DirectoryEntry {
    inode: u32,
    rec_len: u16,
    name_len: u8,
    file_type: u8,
    name: [u8; 256],
}

/* Everything we need to reconstruct the filesystem from a simple data
   structure. "Joe," you might say, "this information is already in the 
   superblock, so why are you duplicating some of it here?" It's to minimize
   dereferencing and hopefully be able to write safer code in the future. */
pub struct Ext2FS {
    sb: *const SuperBlock,
    block_size: u32,
    blocks: u32,
    block_groups: u32,
    inodes_per_group: u32,
    inode_size: u32,
    start_block: u32,
    c_inode: u32,
}

impl Ext2FS {
    /* All functions below use a safe wrapper around a generally unsafe function.
       I will not be providing descrptions of the safe wrappers. */
    /* Initialize a filesystem and store some basic information we need
       about it. The filesystem begins at __fs_start (passed by the linker) +
       1024 bytes: the superblock. All FS info comes from the superblock. */
    unsafe fn _init() -> Ext2FS {
        let sbr = (&__fs_start as *const u32).offset(256);
        let sbp = sbr as *const SuperBlock;
        let bs = 1024 << (*sbp).log_block_size;
        let nblocks = (*sbp).blocks_cnt;
        let nblock_groups = nblocks / (*sbp).blocks_per_group;
        let fs = Ext2FS {sb: sbr as *const SuperBlock,
            block_size: bs,
            blocks: nblocks,
            block_groups: nblock_groups,
            inodes_per_group: (*sbp).inodes_per_group,
            inode_size: ((*sbp).inode_size) as u32,
            start_block: match bs {
                1024    => 2,
                _       => 1,
            },
            c_inode: 2};
        println!("Initialized ext2fs with superblock at: {:p}", fs.sb);
        return fs;
    }
    
    pub fn init() -> Ext2FS {
        unsafe { return Ext2FS::_init(); }
    }

    /* Get some information about the filesystem to show that it is, indeed
       a valid filesystem. */
    unsafe fn _get_fs_info(&self) {
        println!("Filesystem information: ");
        println!("MAGIC NUMBER:     {:X}", (*self.sb).magic);
        println!("Creator:          {}", match (*self.sb).creator_os {
            0   => "Linux",
            1   => "GNU HURD (really?)",
            2   => "MASIX",
            3   => "FreeBSD",
            4   => "Lites",
            _   => "Unknown bullshit"
        });
        println!("inode count:      {}", (*self.sb).inodes_cnt);
        println!("Block count:      {}", (*self.sb).blocks_cnt);
        println!("Root block count: {}", (*self.sb).r_blocks_cnt);
        println!("Free blocks:      {}", (*self.sb).f_blocks_cnt);
        println!("Free inodes:      {}", (*self.sb).f_inodes_cnt);
        println!("Block size:       {} bytes", self.block_size);
        println!("inode size:       {} bytes", self.inode_size);
        println!("Blocks per group: {}", (*self.sb).blocks_per_group);
        println!("inodes per group: {}", self.inodes_per_group);
        println!("Block groups:     {}", self.block_groups);
    }

    pub fn get_fs_info(&self) {
        unsafe { self._get_fs_info(); }
    }

    /* Read an individual block descriptor. This contains information about
       groups of data blocks on the filesystem that should allow us to 
       reconstruct enough to start reading inodes, which will allow us to
       start reading data blocks. */
    /* Of course, this function prints out the information in a human-readable
       format. */
    unsafe fn _read_block_descriptor(&self, blk: u32) {
        /* This is a bizarre way of having to do this, but here we are. */
        /* This allows easier offseting than using another type and since,
           technically, the block size isn't necesarilly known ahead of time,
           we can't just define a block as a structure. Lame. */
        let fsb = &__fs_start as *const _ as u32 as *const u8;
        let start_block = match self.block_size {
            1024    =>  2,
            _       =>  1,
        };

        let off = self.block_size * start_block;
        let bgds = (fsb.offset(off as isize)) as *const BlockGroupDescriptorTbl;
        let bgd = bgds.offset(blk as isize);
        println!("Block {}:", blk);
        println!("\tBlock bitmap block: {}", (*bgd).block_bitmap);
        println!("\tinode bitmap block: {}", (*bgd).inode_bitmap);
        println!("\tinode table block:  {}", (*bgd).inode_table);
        println!("\tFree blocks:        {}", (*bgd).free_blocks_cnt);
        println!("\tFree inodes:        {}", (*bgd).free_inodes_cnt);
        println!("\tUsed directories:   {}", (*bgd).used_dirs_cnt);
    }

    pub fn read_block_descriptor(&self, blk: u32) {
        if blk < 0 || blk > self.block_groups {
            println!("Invalid block index.");
        }
        else {
            unsafe { self._read_block_descriptor(blk); }
        }
    }

    /* Instead of reading one block descriptor, read them all. */
    pub fn read_block_descriptors(&self) {
        for i in 0..self.block_groups {
            self.read_block_descriptor(i);
        }
    }
    
    /* Get a pointer to a data block from a block number. Saves some
       repeated code in subsequent functions. */
    unsafe fn _get_block(&self, idx: u32) -> *const u8 {
        let fsb = &__fs_start as *const _ as u32 as *const u8;
        let block_off = (self.block_size * idx) as isize;
        let blk = fsb.offset(block_off) as *const u8;
        return blk;
    }

    /* Likewise, sometimes we need to get an inode from an index.
       This does that. */
    unsafe fn _get_inode(&self, id: u32) -> *const Inode {
        /* Get inode and block index information based off fs structure
           from superblock */
        let inodes_per_block = self.block_size / self.inode_size;
        let bg = (id - 1) / self.inodes_per_group;
        let idx = (id - 1) % self.inodes_per_group;
        let blk_idx = idx * self.inode_size / self.block_size;
        //println!("Inode {} is in bg {} with idx {} and blk_idx {}",
        //         id, bg, idx, blk_idx);

        /* Now find the actual inode structure.*/
        let fsb = &__fs_start as *const _ as u32 as *const u8;
        let bgds = self._get_block(self.start_block) as *const BlockGroupDescriptorTbl;
        let bgd = bgds.offset(bg as isize);
        let inode_block = (*bgd).inode_table + blk_idx;
        let block_as_inodes = self._get_block(inode_block) as *const Inode;
        let inode_final = block_as_inodes.offset((idx % inodes_per_block) as isize);
        return inode_final;
    }

    /* Read a directory inode and its contents */
    /* c_inode is an inode number representing the current directory.
       File inodes are handled differently. Since the type Ext2FS stores its
       current directory, each process using the filesystem must maintain its
       own instance of Ext2FS. This isn't really a problem. */
    /* Equivalent to ls */
    unsafe fn _read_directory_inode(&self) {
        let inode_final = self._get_inode(self.c_inode);
        println!("inode type = {}", match ((*inode_final).mode & 0xF000) {
            0x8000  => "FILE",
            0x4000  => "DIR",
            _       => "UNSUPPORTED",
        });
        /*print!("data blocks: ");
        for j in 0..15 {
            if (*inode_final).block[j] != 0 {
                print!("{}", (*inode_final).block[j]);
            }
        }*/
        println!("");

        /* The great thing about a directory entry is that it's a linked list with
           byte displacements, so we get to do some questionable casting. */
        for j in 0..15 {
            if(*inode_final).block[j] == 0 {
                break;
            }
            let dir_content_block = self._get_block((*inode_final).block[j]) as *const DirectoryEntry;
            let mut byteable_dir = dir_content_block.offset(0) as *const u8;
            let mut dir = dir_content_block.offset(0);
            println!("TYPE     INODE     SIZE (BYTES)     NAME");
            loop {
                let tgt_inode = self._get_inode((*dir).inode);
                print!("{0:4}", match(*dir).file_type {
                    1   => "FILE",
                    2   => "DIR",
                    _   => "NOPE",
                });
                print!("     {:0>5}     ", (*dir).inode);
                print!("{:0>12}     ", (*tgt_inode).size);
                for k in 0..(*dir).name_len {
                    print!("{}", (*dir).name[k as usize] as char);
                }
                println!("");
                byteable_dir = byteable_dir.offset((*dir).rec_len as isize);
                dir = byteable_dir as *const DirectoryEntry;
                /* I'm not sure why it's looping back and printing . and ..
                   a second time, with bad values, but the extra logic will
                   stop that. */
                if (*dir).inode == 0 || (*dir).rec_len == 0 || ((*dir).name_len == 1 && (*dir).name[0] == '.' as u8) 
                {
                    break;
                }
            }           
        }
    }
    
    pub fn read_directory_inode(&self) {
        unsafe { self._read_directory_inode(); }
    }

    /* Change directory. We're not supporting complex changes. You can just 
       move up or down one in the filesystem. */
    unsafe fn _fs_cd(&mut self, name: &str) -> u32 {
        let inode_final = self._get_inode(self.c_inode);
        for j in 0..15 {
            if(*inode_final).block[j] == 0 {
                break;
            }
            let dir_content_block = self._get_block((*inode_final).block[j]) as *const DirectoryEntry;
            let mut byteable_dir = dir_content_block.offset(0) as *const u8;
            let mut dir = dir_content_block.offset(0);
            /* Name matching in this is a pain in the ass. */
            loop {
                if name.len() == (*dir).name_len as usize {
                    for k in 0..(*dir).name_len {
                        if name.as_bytes()[k as usize] != (*dir).name[k as usize] {
                            break;
                        }
                        /* If you're here, you've found a NAME match! */
                        /* Make sure we're changing to a dir and not a file */
                        if (*dir).file_type != 2 {
                            return 1;
                        }
                        self.c_inode = (*dir).inode;
                        return 0;
                    }
                }
                byteable_dir = byteable_dir.offset((*dir).rec_len as isize);
                dir = byteable_dir as *const DirectoryEntry;
                /* I'm not sure why it's looping back and printing . and ..
                   a second time, with bad values, but the extra logic will
                   stop that. */
                if (*dir).inode == 0 || (*dir).rec_len == 0 || ((*dir).name_len == 1 && (*dir).name[0] == '.' as u8) 
                {
                    break;
                }
            }
            /* If we made it this far, it's just not found. Sorry bruh. */
            return 2;
        }
        return 3;
    }

    pub fn fs_cd(&mut self, name: &str) -> u32 {
        unsafe { return self._fs_cd(name); }
    }
}
