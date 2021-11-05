# build container
FROM    debian:stable-slim

RUN     apt-get -q update && apt-get -qy upgrade && apt-get -qy install clang make curl python

ARG     cmake_version=3.21
ARG     cmake_revision=4
WORKDIR /root
RUN     curl -OJL https://github.com/Kitware/CMake/releases/download/v${cmake_version}.${cmake_revision}/cmake-${cmake_version}.${cmake_revision}-linux-x86_64.tar.gz
RUN     tar -xzf cmake-${cmake_version}.${cmake_revision}-linux-x86_64.tar.gz
WORKDIR /root/cmake-${cmake_version}.${cmake_revision}-linux-x86_64
RUN     cp -rf ./bin ./share /usr/local

ARG     nasm_version=2.15.05
WORKDIR /root
RUN     curl -OJ https://www.nasm.us/pub/nasm/releasebuilds/${nasm_version}/nasm-${nasm_version}.tar.gz
RUN     tar -xzvf nasm-${nasm_version}.tar.gz
WORKDIR /root/nasm-${nasm_version}
RUN     ./configure && make && make install

WORKDIR /tmp/cmake-nasm-test
COPY    ./ /tmp/cmake-nasm-test
RUN     make -s clean build

# run container
FROM alpine:latest

COPY --from=0 /tmp/cmake-nasm-test/build/nasm-test /usr/local/bin/nasm-test

CMD ["nasm-test"]
