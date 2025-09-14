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
    mov rdi, 0
    syscall

; global -> make a symbol visible to the linker
; section -> organizes code and data into logical segments with specific permissions

; section .text   -> Executable code (instructions)
; section .data   -> initialized, read-write data
; section .bss    -> uinitialized, read-write data
; section .rodata -> initialized read-only data

; rax -> Syscall number
; rdi -> 1st argument
; rsi -> 2nd  ""
; rdi -> 3rd  ""
; r10 -> 4th  ""
; r8  -> 5th  ""
; r9  -> 6th  ""

; db  -> Define byte
; dw  -> Define word(2 byte)
; dd  -> Define double word(4 byte)
; dq  -> Define quad word(8 byte)
; dt  -> Define ten byte
; equ -> Define symbolic constants
