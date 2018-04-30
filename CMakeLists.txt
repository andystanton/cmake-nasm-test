cmake_minimum_required(VERSION 3.7)
set(project_name "nasm-test")
project(${project_name} ASM_NASM)

set(CMAKE_NASM_LINK_EXECUTABLE "ld -o <TARGET> <OBJECTS>")
set(CAN_USE_ASSEMBLER TRUE)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
endif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

if (${CMAKE_SYSTEM_NAME} MATCHES "Linux")
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
endif (${CMAKE_SYSTEM_NAME} MATCHES "Linux")

enable_language(ASM_NASM)

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set(CMAKE_ASM_NASM_FLAGS "-DMACOS")
endif (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")

set(SOURCE_FILES src/asm/helloworld.asm)

add_executable(${project_name} ${SOURCE_FILES})
set_target_properties(${project_name} PROPERTIES LINKER_LANGUAGE NASM)
