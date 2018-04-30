# CMake NASM Test
 
This project builds a hello world console application in x86-64 assembly with NASM using CMake.

## Requirements

* NASM
* CMake, Make and ld

## Usage

This command will build the application on Linux and MacOS with recent NASM (tested with 2.13):

```sh
$ make run
```

Alternatively, this command will prepare a Debian-based Docker container and build and execute the application in it:

```sh
$ make docker
```
