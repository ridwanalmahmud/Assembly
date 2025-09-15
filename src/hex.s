; output rax value in hex format

section .data
    codes: db "0123456789ABCDEF"

section .text
global _start

_start:
    mov rax, 0x1122334455667788
    mov rdi, 1
    mov rdx, 1
    mov rcx, 64 ; bit counter: start from the most significant bit (64 bits total)

loop:
    push rax

   ; prepare to extract the next 4-bit nibble
    sub rcx, 4   ; decrement bit counter by 4 (move to next nibble)
    sar rax, cl  ; shift right to bring the target nibble to the least significant bits
    and rax, 0xf ; mask to get only the lowest 4 bits (0-15)

    ; calculate address of the corresponding hex character
    lea rsi, [codes + rax] ; load address of the hex character from lookup table
    mov rax, 1             ; syscall number: sys_write (1)

    push rcx
    syscall
    pop rcx

    pop rax
    test rcx, rcx
    jnz loop

    ; exit
    mov rax, 60
    xor rdi, rdi
    syscall
