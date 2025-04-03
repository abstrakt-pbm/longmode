cmake_minimum_required(VERSION 3.20)

project( lmode)

set(CMAKE_CXX_COMPILER g++)


set(CMAKE_ASM_NASM_COMPILER nasm)
set(CMAKE_ASM_NASM_FLAGS "-f elf64")
enable_language( ASM_NASM )

set (ASM_FILES 
    "init.asm"
)

set ( LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/link.ld )

add_executable( lmode.elf ${ASM_FILES})

target_link_options(lmode.elf PRIVATE -T ${LINKER_SCRIPT} -static -m elf_x86_64 )


