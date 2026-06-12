unsafe();
; var int32_t var_34h @ stack - 0x34
; var int32_t var_8h @ stack - 0x8
0x08049172      55                     push    ebp ;  Prologue - Preserve caller's frame pointer
0x08049173      89e5                   mov     ebp, esp ; Set EBP to ESP; both point at top of stack
0x08049175      53                     push    ebx ; In x86 helper functions are called to find the GOT offset which is typically stored in EBX; this callee function preserves caller's EBX.
0x08049176      83ec34                 sub     esp, 0x34 ; Allocate 52 bytes of space in this stack frame
0x08049179      e832ffffff             call    __x86.get_pc_thunk.bx ; sym.__x86.get_pc_thunk.bx ; x86 convention to get EIP current value into EBX
0x0804917e      81c3822e0000           add     ebx, 0x2e82 ; 11906 bytes added to EBX
0x08049184      83ec0c                 sub     esp, 0xc ; Allocate 12 bytes to RSP
0x08049187      8d8308e0ffff           lea     eax, [ebx - 0x1ff8] ; Load address at EBX - 0x1ff8 || This essentially finds the current memory address which should be 0x0804917e then subtracts 0x1ff8 to get 0x804A008
0x0804918d      50                     push    eax ; const char *s ; .string "Overflow me" ; len=12 | Push EAX of 0x804A008 onto stack drops ESP another 4 bytes thus maintaining alignment
0x0804918e      e8adfeffff             call    puts ; sym.imp.puts ; Calling puts; autoappends \n ; int puts(const char *s)
0x08049193      83c410                 add     esp, 0x10 ; Add 16 bytes from ESP; thus moving it closer to EBP
0x08049196      83ec0c                 sub     esp, 0xc ; Drops EAX by 12 bytes; combined with PUSH EAX maintains alignment
0x08049199      8d45d0                 lea     eax, [var_34h] ; Load memory address of s into EAX
0x0804919c      50                     push    eax ; char *s ; Pushing EAX onto stack holding memory address of S; This drops ESP by 4 bytes; ESP is aligned before call
0x0804919d      e88efeffff             call    gets ; sym.imp.gets ; Call gets. Since this is x86 architecture using CDECL calling convention, it's using the memory address of the string on the stack as an arg. ; char *gets(char *s)
0x080491a2      83c410                 add     esp, 0x10 ; Remove 16 bytes from ESP; caller cleans up the space allocated for gets due to caller cleanup CDECL convention
0x080491a5      90                     nop ; NOP for hardware optimization; doesn't impact stack or RE
0x080491a6      8b5dfc                 mov     ebx, dword [var_8h] ; Restore callee's initial EBX value
0x080491a9      c9                     leave ; LEAVE automates a portion of the prologue; it moves ESP back to EBP and POPs the caller's frame pointer of 4 bytes back into EBP. ESP now points at what was before EBP; which is the EIP of the caller. This also deallocates EBX which was pushed onto the stack, since it was pushed after EBP.
0x080491aa      c3                     ret ; Return pops the saved return address back into EIP, transferring control to the caller.
