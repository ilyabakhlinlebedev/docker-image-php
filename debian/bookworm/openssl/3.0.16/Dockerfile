FROM debian:bookworm AS base

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y dist-upgrade && \
    apt-get -qq -y clean && \
    apt-get -qq -y autoclean && \
    apt-get -qq -y autoremove

FROM base AS build

RUN apt-get -qq -y install build-essential

FROM base AS wget

RUN apt-get -qq -y install wget

FROM wget AS wget-openssl

RUN mkdir -p -v /tmp/openssl/3.0.16

RUN wget -O - -q "https://github.com/openssl/openssl/releases/download/openssl-3.0.16/openssl-3.0.16.tar.gz" | tar -C /tmp/openssl/3.0.16/ -o --strip-components 1 -v -x -z

FROM build AS build-openssl

COPY --from=wget-openssl /tmp/openssl/3.0.16/ /tmp/openssl/3.0.16/

WORKDIR /tmp/openssl/3.0.16/

RUN ./config \
    --openssldir=/opt/openssl/3.0.16 \
    --prefix=/opt/openssl/3.0.16 \
    no-shared

RUN make -j $(nproc) && make install

FROM scratch AS openssl

COPY --from=build-openssl /opt/openssl/3.0.16/ /opt/openssl/3.0.16/
