FROM debian:bookworm AS base

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y dist-upgrade && \
    apt-get -qq -y clean && \
    apt-get -qq -y autoclean && \
    apt-get -qq -y autoremove

FROM base AS build

RUN apt-get -qq -y install build-essential pkg-config

FROM base AS wget

RUN apt-get -qq -y install wget

FROM wget AS wget-curl

RUN mkdir -p -v /tmp/curl/7.88.1

RUN wget -O - -q "https://curl.se/download/curl-7.88.1.tar.gz" | tar -C /tmp/curl/7.88.1 -o --strip-components 1 -v -x -z

FROM build AS build-curl

COPY /opt/brotli/1.1.0/ /opt/brotli/1.1.0/
COPY /opt/openssl/3.0.16/ /opt/openssl/3.0.16/
COPY /opt/zlib/1.2.13/ /opt/zlib/1.2.13/
COPY /opt/zstd/1.5.7/ /opt/zstd/1.5.7/

COPY --from=wget-curl /tmp/curl/7.88.1/ /tmp/curl/7.88.1/

WORKDIR /tmp/curl/7.88.1/

ARG CFLAGS="-I/opt/brotli/1.1.0/include"
ARG LDFLAGS="-L/opt/brotli/1.1.0/lib"
ARG LIBS="-l:libbrotlicommon.a -l:libbrotlidec.a -l:libbrotlienc.a"
ARG PKG_CONFIG_PATH="/opt/openssl/3.0.16/lib64/pkgconfig:/opt/zlib/1.2.13/lib/pkgconfig:/opt/zstd/1.5.7/lib/pkgconfig"

RUN ./configure \
    --disable-shared \
    --prefix=/opt/curl/7.88.1 \
    --with-brotli \
    --with-gnu-ld \
    --with-openssl \
    --with-zlib \
    --with-zstd

RUN make -j $(nproc) && make install

FROM scratch AS curl

COPY --from=build-curl /opt/curl/7.88.1/ /opt/curl/7.88.1/
