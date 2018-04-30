FROM    debian
RUN     apt update && apt upgrade -y && apt install -y clang make curl python
WORKDIR /root
RUN     curl -OJ https://www.nasm.us/pub/nasm/releasebuilds/2.13.03/nasm-2.13.03.tar.gz
RUN     tar -xzvf nasm-2.13.03.tar.gz
WORKDIR /root/nasm-2.13.03
RUN     ./configure && make && make install
WORKDIR /root
RUN     curl -OJ https://cmake.org/files/v3.11/cmake-3.11.1-Linux-x86_64.tar.gz
RUN     tar -xzf cmake-3.11.1-Linux-x86_64.tar.gz
WORKDIR /root/cmake-3.11.1-Linux-x86_64
RUN     cp -rf ./bin ./share /usr/local
WORKDIR /tmp/cmake-nasm-test
COPY    ./ /tmp/cmake-nasm-test
