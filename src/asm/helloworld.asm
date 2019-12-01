%ifdef      MACOS
%define     ENTRYPOINT      _main
%define     SYSCALL_WRITE   0x2000004
%define     SYSCALL_EXIT    0x2000001
%else
%define     ENTRYPOINT      start
%define     SYSCALL_WRITE   1
%define     SYSCALL_EXIT    60
%endif

            section         .text
            global          ENTRYPOINT

ENTRYPOINT: mov             rax, SYSCALL_WRITE  ; write
            mov             rdi, 1              ; stdout
            mov             rsi, msg
            mov             rdx, msg.len
            syscall
            mov             rax, SYSCALL_EXIT   ; exit
            mov             rdi, 0              ; return 0
            syscall

            section         .data

msg         db              'Hello world', 0x0A ; 'Hello world' followed by newline
.len        equ             $ - msg
