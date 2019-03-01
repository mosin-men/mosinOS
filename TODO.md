# Urgent
  check to see if we can ecall from User mode
#Lab 5 - Due 3/8 6pm
## Memory Manager
  Kalloc
  - will need to design a free list system
  Kfree
  - will need to design a free list system
## PMP
  API for sectioning kernal heap space
  -Lab 6 will use this to set up memory for processes
## ECalls
  exit
  write 
  - TBD, probably depends on init process
  read  
  - TBD, probably depends on init process
  alloc
  free
  barrier (??)
# Lab 6 - Due 3/27 6pm 
## Scheduler
  - Need a Balanced Binary Tree with a point to far left node
  1. ~~Catch timer interrupt~~
  2. ~~save context (Done)~~
  3. query scheduler
  4. get new process context
  5. ~~load new context~~
  6. ~~return from timer to new process~~
## Process Handler
### Structure
  Regs - GLOBAL_CTX
  PC   - mepc
  State - {Running, Sleeping_IO, Sleeping_TI}
  Parent(??)
  - if we want to do forking process spawning
# Lab 7 - Due 4/12 6pm
## File System
