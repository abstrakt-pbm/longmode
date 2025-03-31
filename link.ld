ENTRY(_start_init)

SECTIONS {
    . = 0x100000;

    /* Секция для заголовка Multiboot2 */
    .multiboot2 ALIGN(8) : {
        *(.multiboot2)
    } :headers

    /* Секция для кода ядра */
    .text ALIGN(4K) : {
        *(.text)
        *(.text.*)
    } :text

    /* Секция для только чтения данных */
    .rodata ALIGN(4K) : {
        *(.rodata)
        *(.rodata.*)
    } :rodata

    /* Секция для данных */
    .data ALIGN(4K) : {
        *(.data)
        *(.data.*)
    } :data

    /* Секция для незаполненной памяти (BSS) */
    .bss ALIGN(4K) : {
        *(COMMON)
        *(bss)
    } :bss

    __bss_end = .;
}

PHDRS {
    headers PT_PHDR PHDRS FLAGS(4);   /* Программный заголовок для структуры ELF */
    text    PT_LOAD FILEHDR PHDRS FLAGS(5);  /* Чтение + Исполнение */
    rodata  PT_LOAD FLAGS(4);         /* Только чтение */
    data    PT_LOAD FLAGS(6);         /* Чтение + Запись */
    bss     PT_LOAD FLAGS(6);         /* Чтение + Запись */
}
