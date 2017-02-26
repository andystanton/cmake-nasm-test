FROM    debian
RUN     apt update && apt upgrade -y && apt install -y clang make curl python
WORKDIR /root
RUN     curl -OJ http://www.nasm.us/pub/nasm/releasebuilds/2.12.02/nasm-2.12.02.tar.gz
RUN     tar -xzvf nasm-2.12.02.tar.gz
WORKDIR /root/nasm-2.12.02
RUN     ./configure && make && make install
WORKDIR /root
RUN     curl -OJ https://cmake.org/files/v3.7/cmake-3.7.2.tar.gz
RUN     tar -xzvf cmake-3.7.2.tar.gz
WORKDIR /root/cmake-3.7.2
RUN     ./configure && make && make install
COPY    ./ /tmp/cmake-nasm-test
WORKDIR /tmp/cmake-nasm-test
