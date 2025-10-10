# CMake NASM Test

This project builds a hello world console application in x86-64 assembly with NASM using CMake.

## Requirements

* NASM 3.00+
* CMake 3.20+
* Make and ld
* macOS: Rosetta 2 (for Apple Silicon Macs)

## Usage

This command will build the application on Linux and macOS (11.0+):

```sh
$ make run
```

Alternatively, this command will prepare an Alpine-based Docker container and execute the application in it:

```sh
$ make docker
```
