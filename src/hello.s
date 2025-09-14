section .data
    msg: db "hello, world!", 10
    msg_len equ $ - msg

section .text
    global _start

_start:
    ; write syscall
    mov rax, 1
    mov rdi, 1
    mov rsi, msg
    mov rdx, msg_len
    syscall

    ; exit syscall
    mov rax, 60
    xor rdi, rdi
    syscall
