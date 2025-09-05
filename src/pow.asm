; assembly functions using C calling conventions
; calculate 2^3 + 5^2 with functions
; in memory the stack starts at the top of memory and grows downward
; top of the stack = bottom of the stacks memory
; rsp contains the a pointer to the current top of the stack
; with push onto the stack rsp gets subtracted by 8
; with pop from the stack rsp gets added by 8
; parameter for the function are pushed onto the stack in reverse order
; call intruction does 2 things ->
; 1. it pushes the address of the next instruction on the stack which is the retuen value
; 2. the it modifies rip to point to the start of the function
; the first thing the function does is save rbp
; rbp is a special register that used for accessing function parameters and local variables
; then copies the stack pointer to rbp
; this allows us to access the parameters as fixed indexes
; rbp will always be where the stack pointer was at the beginning of the function so its a reference to the stack frame
; then the function reverses space for any local variables it needs
; this is done by moving the stack pointer out of the way
; if we need to words of memory, we can do so by sub, 16, rsp
; since this is allocated on the stack frame the variables lifefime is only this function
; the stack now looks like this
; parameter 2       <-- rbp + 32
; parameter 1       <-- rbp + 16
; return address    <-- rbp + 8
; old rbp           <-- rbp
; local variable 1  <-- rbp - 8
; local variable 2  <-- rbp - 16
; ret instruction pops whatever value was on top of the stack and sets rip to that value

section .data

section .text
    global _start

; ebx holds the base power
; rcx holds the power

_start:
    ; for 2^3
    push 3              ; push second argument
    push 2              ; push first argument
    call pow            ; call pow function
    add rsp, 16         ; move the stack pointer back
    push rax            ; save the first answer before calling the function
    ; for 5^2
    push 2              ; push second argument
    push 5              ; push first argument
    call pow            ; call pow function
    add rsp, 16         ; move the stack pointer back
    pop rbx             ; the second answer is already in rax.
                        ; the first answer is already on the stack.
                        ; so now we pop it out of rbx
    add rbx, rax        ; (2^3+5^2), put the result in tbx
    mov rax, 60         ; exit syscall number
    mov rdi, rbx        ; return value
    syscall             ; make the syscall

pow:
    push rbp            ; save the base pointer
    mov rbp, rsp        ; make stack pointer the base pointer
    sub rsp, 8          ; ...get room for local storage
    mov rbx, [rbp + 16] ; put first argument in rbx
    mov rcx, [rbp + 24] ; put second argument in rcx
    mov [rbp - 8], rbx  ; ...store current result
    ; mov rax, rbx      ; we could just use this and remove all the (...) lines

pow_loop_start:
    cmp rcx, 1          ; if power is one we are done
    je pow_end          ; end the loop
    mov rax, [rbp - 8]  ; ...move current result into rax
    imul rax, rbx       ; multiply the current result by the base number
    mov [rbp - 8], rax  ; ...store the current result
    dec rcx             ; decrease the power
    jmp pow_loop_start  ; run for the next power

pow_end:
    mov rax, [rbp - 8]  ; ...return value goes in rax
    mov rsp, rbp        ; restore the stack pointer
    pop rbp             ; restore the base pointer
    ret                 ; return
