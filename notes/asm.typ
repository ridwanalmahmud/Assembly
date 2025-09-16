#set text(
    font: "Monaspace Radon Frozen",
    size: 16pt,
)

#align(center)[
    #underline(text(fill: blue, weight: "bold", size: 24pt)[Assembly])
]
- global -> make a symbol visible to the linker
- section -> organizes code and data into logical segments with specific permissions

=== === Section Directives ===
- section .text   -> Executable code (instructions)
- section .data   -> initialized, read-write data
- section .bss    -> uinitialized, read-write data
- section .rodata -> initialized read-only data

=== === System calls ===
- rax -> Syscall number
- rdi -> 1st argument
- rsi -> 2nd  ""
- rdi -> 3rd  ""
- r10 -> 4th  ""
- r8  -> 5th  ""
- r9  -> 6th  ""

=== === Data directives ===
- db  -> Define byte
- dw  -> Define word(2 byte)
- dd  -> Define double word(4 byte)
- dq  -> Define quad word(8 byte)
- dt  -> Define ten byte
- equ -> Define symbolic constants
