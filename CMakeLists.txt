cmake_minimum_required(VERSION 3.20)
cmake_minimum_required(VERSION 3.20)

project(nasm-test
    VERSION 1.0.0
    LANGUAGES ASM_NASM
    DESCRIPTION "Hello World console application in x86-64 assembly with NASM"
)

set(CMAKE_NASM_LINK_EXECUTABLE "ld <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")
set(CAN_USE_ASSEMBLER TRUE)

if(APPLE)
    # Detect architecture
    execute_process(
        COMMAND uname -m
        OUTPUT_VARIABLE ARCH
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(ARCH STREQUAL "arm64")
        # Apple Silicon: build for x86_64 under Rosetta 2
        set(CMAKE_OSX_ARCHITECTURES "x86_64")
        set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
        set(CMAKE_ASM_NASM_COMPILE_OBJECT "<CMAKE_ASM_NASM_COMPILER> <INCLUDES> <FLAGS> -f macho64 -o <OBJECT> <SOURCE>")
        set(CMAKE_ASM_NASM_FLAGS "-DMACOS")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -arch x86_64 -platform_version macos 11.0 11.0 -no_pie -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib")
    else()
        # Intel Mac
        set(CMAKE_ASM_NASM_OBJECT_FORMAT macho64)
        set(CMAKE_ASM_NASM_FLAGS "-DMACOS")
        set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -platform_version macos 11.0 11.0 -no_pie -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib")
    endif()
endif()

if(UNIX AND NOT APPLE)
    set(CMAKE_ASM_NASM_OBJECT_FORMAT elf64)
endif()

enable_language(ASM_NASM)

add_executable(${PROJECT_NAME} src/asm/helloworld.asm)
set_target_properties(${PROJECT_NAME} PROPERTIES LINKER_LANGUAGE NASM)

if(APPLE)
    target_link_libraries(${PROJECT_NAME} PRIVATE System)
endif()
