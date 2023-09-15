# build container
FROM    debian:stable
RUN     apt-get -q update && apt-get -qy upgrade && apt-get -qy install cmake curl
ARG     nasm_version=2.16.01
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
