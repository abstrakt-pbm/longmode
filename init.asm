section .multiboot2
    align 8
    magic dd 0xE85250D6
    version dd 0x00010002
    header_length dd multiboot2_header_end - multiboot2_header_start
    reserved dd 0
    checksum dd -(0xE85250D6 + 0 + (multiboot2_header_end - multiboot2_header_start))

multiboot2_header_start:
    dw 0
    dw 0
    dd 8

multiboot2_header_end:

section .text
global _start_init
_start_init:
    bits 32
    hlt
    