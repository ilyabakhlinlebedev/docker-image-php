FROM debian:bookworm AS base

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y dist-upgrade && \
    apt-get -qq -y clean && \
    apt-get -qq -y autoclean && \
    apt-get -qq -y autoremove

FROM base AS build

RUN apt-get -qq -y install cmake build-essential pkg-config

FROM base AS wget

RUN apt-get -qq -y install wget

FROM wget AS wget-brotli

RUN mkdir -p -v /tmp/brotli/1.1.0

RUN wget -O - -q "https://github.com/google/brotli/archive/refs/tags/v1.1.0.tar.gz" | tar -C /tmp/brotli/1.1.0/ -o --strip-components 1 -v -x -z

FROM build AS build-brotli

COPY --from=wget-brotli /tmp/brotli/1.1.0/ /tmp/brotli/1.1.0/

WORKDIR /tmp/brotli/1.1.0/

RUN cmake \
    -DBROTLI_DISABLE_TESTS=ON \
    -DBUILD_SHARED_LIBS=OFF \
    -DCMAKE_INSTALL_PREFIX=/opt/brotli/1.1.0

RUN make -j $(nproc) && make install

FROM scratch AS brotli

COPY --from=build-brotli /opt/brotli/1.1.0/ /opt/brotli/1.1.0/
