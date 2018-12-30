# CMake NASM Test
 
This project builds a hello world console application in x86-64 assembly with NASM using CMake.

## Requirements

* NASM
* CMake, Make and ld

## Usage

This command will build the application on Linux and MacOS (10.13+) with recent NASM (tested with 2.14):

```sh
$ make run
```

Alternatively, this command will prepare an Alpine-based Docker container and execute the application in it.

```sh
$ make docker
```
