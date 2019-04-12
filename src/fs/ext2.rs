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

pub struct Ext2FS {
    sb: *const SuperBlock,
    block_size: u32,
    blocks: u32,
    block_groups: u32,
    c_inode: u32,
}

impl Ext2FS {
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
            c_inode: 2};
        println!("Initialized ext2fs with superblock at: {:p}", fs.sb);
        return fs;
    }
    
    pub fn init() -> Ext2FS {
        unsafe { return Ext2FS::_init(); }
    }

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
        println!("inode size:       {} bytes", (*self.sb).inode_size);
        println!("Blocks per group: {}", (*self.sb).blocks_per_group);
        println!("inodes per group: {}", (*self.sb).inodes_per_group);
        println!("Block groups:     {}", self.block_groups);
    }

    pub fn get_fs_info(&self) {
        unsafe { self._get_fs_info(); }
    }

    unsafe fn _read_block_descriptor(&self) {
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
        for bgdi in 0..self.block_groups {
            let bgd = bgds.offset(bgdi as isize);
            println!("Block {}: {} {}", bgdi, (*bgd).block_bitmap, (*bgd).inode_bitmap);
            println!("\t{}", (*bgd).inode_table);
            println!("\t{} {}", (*bgd).free_blocks_cnt, (*bgd).free_inodes_cnt);
            println!("\t{}", (*bgd).used_dirs_cnt);
        }
    }

    pub fn read_block_descriptor(&self) {
        unsafe { self._read_block_descriptor(); }
    }
}
