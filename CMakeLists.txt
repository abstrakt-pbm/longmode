cmake_minimum_required(VERSION 3.20)

project( lmode)

set(CMAKE_CXX_COMPILER g++)

set(CMAKE_C_FLAGS "-ffreestanding -nostdlib -nostartfiles -fno-exceptions -fno-rtti -fno-asynchronous-unwind-tables -fno-unwind-tables")
set(CMAKE_CXX_FLAGS "-ffreestanding -nostdlib -nostartfiles -fno-exceptions -fno-rtti -fno-asynchronous-unwind-tables -fno-unwind-tables")
set(CMAKE_ASM_NASM_COMPILER nasm)
set(CMAKE_ASM_NASM_FLAGS "-f elf64")
enable_language( ASM_NASM )

set (ASM_FILES 
    "init.asm"
)

set ( LINKER_SCRIPT ${CMAKE_SOURCE_DIR}/link.ld )

add_executable( lmode.elf main.cpp ${ASM_FILES})

target_link_options(lmode.elf PRIVATE -T ${LINKER_SCRIPT} -static -m64  )


