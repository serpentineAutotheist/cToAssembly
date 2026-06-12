int main()

; Function prologue
0x140001490      55                     push    rbp ; Prologue - Preserve caller's base pointer
0x140001491      4889e5                 mov     rbp, rsp ; Sets the current function's base pointer
0x140001494      4883ec20               sub     rsp, 0x20 ; Subtracts 32 bytes from RSP; thus allocating shadow space (0x20)

; Identifying compiler environmental footprints is important for Rev Eng
0x140001498      e8a3020000             call    dbg.__main ; Call GCC main initialization function. This is an environmental footprint of GCC. ;  __main(void)

; Moving parameters into R8, RDX, RCX prior to a function call - AMD64 Microsoft ABI fastcall convention. Then call the function
0x14000149d      41b80a000000           mov     r8d, 0xa ; Move 10b into r8's 32 bit register; r8d
0x1400014a3      ba00000000             mov     edx, 0 ; Move 0 into EDX; this clears the preceding 0-31 bits of RDX also
0x1400014a8      b92c010000             mov     ecx, 0x12c ; Move 300b into ECX; RCX upper bits cleared
0x1400014ad      e83e000000             call    dbg.fc_table ; dbg.fc_table ; fc_table function call. This decrements RSP by 0x8 bytes and then pushes the RIP of 0x140014b2 onto the stack. ;  fc_table(int upper, int lower, int step)

;Load the string to be printed and print it. In this case, \n.
0x1400014b2      488d05472b0000         lea     rax, [section..rdata] ; 0x140004000 ; Load the rdata section starting memory address into RAX - This exact address contains the newline character we want to print.
0x1400014b9      4889c1                 mov     rcx, rax ; Move the 0x140004000 value from RAX into RCX. In optimized compilations, the LEA instruction should load this value directly into RCX.
0x1400014bc      e837160000             call    puts ; sym.puts ; The compiler made an optimization here, electing for puts over printf since the string has no format specifiers otherwise. This is faster.

; This string is larger than 8 bytes, so it's passed in as a reference to its location in rdata, then moved into RCX before printf is called.
0x1400014c1      488d053a2b0000         lea     rax, [str.GCC_Optimization_Level_1] ;  Load the address of this string which is 0x140004002 into RAX.
0x1400014c8      4889c1                 mov     rcx, rax ; moves data from src to dst; const char *_Format ; Moving RAX into RCX to satisfy Microsoft AMD64 ABI calling convention; -O0 environment footprint
0x1400014cb      e890140000             call    dbg.printf ; dbg.printf ;  Decrement RSP by 0x8 and push RIP which currently holds 0x1400014d0 ; int printf(const char *_Format)

; Preparing to call another function by moving parameters into specific registers
0x1400014d0      41b80a000000           mov     r8d, 0xa ; hw.c:12 ; Moving arguments into registers dictated by AMD64 calling convention again
0x1400014d6      ba00000000             mov     edx, 0 ; int lower
0x1400014db      b92c010000             mov     ecx, 0x12c ; 300 ; int upper
0x1400014e0      e8d0000000             call    dbg.fc_table_optimized ; SUB RSP 0x8; PUSH RIP (0x1400014e5) to stack 

; Function epilogue. Tear down the stack frame and return.
0x1400014e5      b800000000             mov     eax, 0 ;  Return 0
0x1400014ea      4883c420               add     rsp, 0x20 ; Function Epilogue - break down the stack frame and add 32 bytes to RSP; moving it upwards towards stack base
0x1400014ee      5d                     pop     rbp ; Pop caller function's base pointer back into RBP from the stack to continue to index into the caller's function
0x1400014ef      c3                     ret ;   Pop RIP off the stack; returning the execution flow to the line after the caller's "call" operative
