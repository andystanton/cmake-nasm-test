%ifdef          MACOS
    %define     entrypoint              start
    %define     syscall_write           0x2000004
    %define     syscall_exit            0x2000001
%else
    %define     entrypoint              _start
    %define     syscall_write           1
    %define     syscall_exit            60
%endif

section         .text
    global      entrypoint

entrypoint:
    ; syscall parameter info: http://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/
    mov         rax, syscall_write      ; write
    mov         rdi, 1                  ; stdout
    mov         rsi, msg
    mov         rdx, msg.len
    syscall

    mov         rax, syscall_exit       ; exit
    mov         rdi, 0                  ; return 0
    syscall

section         .data

msg     db      'Hello world', 0x0A     ; 'Hello world' followed by newline
.len    equ     $ - msg
