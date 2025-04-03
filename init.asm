section .multiboot2 align = 4096
    MB2_MAGIC  equ 0xE85250D6
    MB2_ARCH   equ 0
    MB2_LENGTH equ 24  ; Длина заголовка + тег окончания
    MB2_CHECKSUM equ -(MB2_MAGIC + MB2_ARCH + MB2_LENGTH)

    dd MB2_MAGIC
    dd MB2_ARCH
    dd MB2_LENGTH
    dd MB2_CHECKSUM

    dd 0    ; Тип (0 = конец заголовка)
    dd 8    ; Длина этого тега (8 байт)

section .init exec
    stack_space: times 4096 db 0;
    pml4_table: times 512 dq 0
    pdpt_table: times 512 dq 0
    pd_table:   times 512 dq 0

global _init_env
_init_env:
    bits 32
    mov esp, stack_space + 4096 ; Инициализация стека
    and esp, -16

    call check_cpu_support_lm 
    test eax, eax
    jz _init_failed

    call switch_cpu_to_lm
    
    hlt

_init_failed:
    hlt

check_cpu_support_lm:
    push ebx
    push ecx

    mov eax, 0x80000000
    cpuid
    cmp eax, 0x80000001
    jb lm_unsupported 

    mov eax, 0x80000001
    cpuid
    test edx, 1 << 29
    jz lm_unsupported

    mov eax, 1
    jmp check_cpu_support_done

    call switch_cpu_to_lm

    hlt

lm_unsupported:
    mov eax, 0

check_cpu_support_done:
    pop ecx
    pop ebx
    ret


switch_cpu_to_lm:

setup_1GB_identity_mapping:
    

section .text
    hlt