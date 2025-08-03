FROM debian:bookworm AS base

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y dist-upgrade && \
    apt-get -qq -y clean && \
    apt-get -qq -y autoclean && \
    apt-get -qq -y autoremove

FROM base AS build

RUN apt-get -qq -y install cmake build-essential

FROM base AS wget

RUN apt-get -qq -y install wget

FROM wget AS wget-libzip

RUN mkdir -p -v /tmp/libzip/1.11.4

RUN wget -O - -q "https://github.com/nih-at/libzip/releases/download/v1.11.4/libzip-1.11.4.tar.gz" | tar -C /tmp/libzip/1.11.4/ -o --strip-components 1 -v -x -z

FROM build AS build-libzip

COPY /opt/openssl/3.0.16/ /opt/openssl/3.0.16/
COPY /opt/zlib/1.2.13/ /opt/zlib/1.2.13/

COPY --from=wget-libzip /tmp/libzip/1.11.4/ /tmp/libzip/1.11.4/

WORKDIR /tmp/libzip/1.11.4/

RUN cmake \
    -DBUILD_DOC=OFF \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_INSTALL_PREFIX=/opt/libzip/1.11.4 \
    -DOPENSSL_CRYPTO_LIBRARY=/opt/openssl/3.0.16/lib64/libcrypto.a \
    -DOPENSSL_INCLUDE_DIR=/opt/openssl/3.0.16/include \
    -DOPENSSL_SSL_LIBRARY=/opt/openssl/3.0.16/lib64/libssl.a \
    -DZLIB_INCLUDE_DIR=/opt/zlib/1.2.13/include \
    -DZLIB_LIBRARY_RELEASE=/opt/zlib/1.2.13/lib/libz.a \
    ./

RUN make -j $(nproc) && make install

FROM scratch AS libzip

COPY --from=build-libzip /opt/libzip/1.11.4/ /opt/libzip/1.11.4/
