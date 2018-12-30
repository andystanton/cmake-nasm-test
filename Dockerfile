FROM    debian
ARG     nasm_version=2.14.02
ARG     cmake_version=3.13
ARG     cmake_revision=2
RUN     apt-get -q update && apt-get -qy upgrade && apt-get -qy install clang make curl python
WORKDIR /root
RUN     curl -OJ https://www.nasm.us/pub/nasm/releasebuilds/${nasm_version}/nasm-${nasm_version}.tar.gz
RUN     tar -xzvf nasm-${nasm_version}.tar.gz
WORKDIR /root/nasm-${nasm_version}
RUN     ./configure && make && make install
WORKDIR /root
RUN     curl -OJ https://cmake.org/files/v${cmake_version}/cmake-${cmake_version}.${cmake_revision}-Linux-x86_64.tar.gz
RUN     tar -xzf cmake-${cmake_version}.${cmake_revision}-Linux-x86_64.tar.gz
WORKDIR /root/cmake-${cmake_version}.${cmake_revision}-Linux-x86_64
RUN     cp -rf ./bin ./share /usr/local
WORKDIR /tmp/cmake-nasm-test
COPY    ./ /tmp/cmake-nasm-test
RUN     make -s clean build

FROM alpine:latest
COPY --from=0 /tmp/cmake-nasm-test/build/nasm-test /usr/local/bin/nasm-test
CMD ["nasm-test"]