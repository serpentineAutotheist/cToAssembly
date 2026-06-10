int main()
0x140001490      55                     push    rbp ; Push current function's base pointer so control flow can resume after main returns
0x140001491      4889e5                 mov     rbp, rsp ; Move the stack pointer into the RBP; now both point at the top of the stack, RBP is now the main function's anchor
0x140001494      4883ec20               sub     rsp, 0x20 ; Subtract 32 bytes from our stack pointer to allocate shadow space for our function. RSP moves down 32 bytes.
0x140001498      e8f3000000             call    dbg.__main ; dbg.__main ; Calls GCC initialization function. RIP is set to the next line's address [0x14000149d] and RSP is decremented by 8 bytes, RIP is then pushed onto the stack.
0x14000149d      488d055c2b0000         lea     rax, [str.Hello__World] ; ; load effective address - LEA loads the address of the Hello World string [0x140004000] from the rdata section into rax 
0x1400014a4      4889c1                 mov     rcx, rax ; Moves the Hello World memory pointer into RCX; which holds the first argument for the function being called.
0x1400014a7      e8f4120000             call    dbg.printf ; Set RIP to next line's memory address [0x1400014ac] and subtracts 8 bytes from RSP to make space then pushes it to stack
0x1400014ac      b800000000             mov     eax, 0 ; hello.c:5 ; Moves 0 into EAX - This is the function's return value, 0. RAX is cleared here, as EAX is its 32 bit / lower half counterpart.
0x1400014b1      4883c420               add     rsp, 0x20 ; hello.c:6 ; Frees up allocated 32 bytes of shadow space for the function, allowing it to be reused
0x1400014b5      5d                     pop     rbp ; Pop the RBP base pointer that was placed on the stack, returning that memory address back to the RBP pointer
0x1400014b6      c3                     ret ;  Pops return address off the stack; returns control flow from main function
