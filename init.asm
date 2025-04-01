section .multiboot2
    align 8
    MB2_MAGIC  equ 0xE85250D6
    MB2_ARCH   equ 0
    MB2_LENGTH equ 24  ; Длина заголовка + тег окончания
    MB2_CHECKSUM equ -(MB2_MAGIC + MB2_ARCH + MB2_LENGTH)

    dd MB2_MAGIC
    dd MB2_ARCH
    dd MB2_LENGTH
    dd MB2_CHECKSUM

    ; Тег окончания заголовка (Multiboot2 требует его!)
    dd 0    ; Тип (0 = конец заголовка)
    dd 8    ; Длина этого тега (8 байт)

section .init 
global _start_init
_start_init:
    bits 32
    hlt

section .text