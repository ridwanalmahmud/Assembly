; find the largest element in a set of numbers
; rdi -> current element index
; rax -> current element data
; rbx -> current largest number
; data_items holds the set of numbers
; will use dq to hold 8 bytes or 64 bit integers
; if we use dd it will load 32 bit integers in 64 bit registers
; if we need to use 32 bit ints that we will have to use eax, ebx, edi
; 0 is used to terminate the data

section .data
    data_items:
        dq 3,54,76,89,21,53,39,64,2,0  ;dd->32 bit, dq->64 bit

section .text
    global _start

_start:
    mov rdi, 0                         ;move 0 into dest index
    mov rax, [data_items + rdi * 8]    ;load the first byte
    mov rbx, rax;as the first item eax is the largest

start_loop:
    cmp rax, 0                         ;check if we hit the end
    je loop_exit                       ;(jump if equal) exit loop
    inc rdi                            ;or increment index
    mov rax, [data_items + rdi * 8]    ;load the next value
    cmp rax, rbx
    jle start_loop                     ;jump if not bigger
    mov rbx, rax                       ;move the value as the largest
    jmp start_loop                     ;jump at the beginning

loop_exit:
    ;rbx now contains the max value
    mov rax, 60
    mov rdi, rbx
    syscall
