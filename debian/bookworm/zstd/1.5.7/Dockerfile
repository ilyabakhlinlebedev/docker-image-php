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

FROM wget AS wget-zstd

RUN mkdir -p -v /tmp/zstd/1.5.7

RUN wget -O - -q "https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz" | tar -C /tmp/zstd/1.5.7/ -o --strip-components 1 -v -x -z

FROM build AS build-zstd

COPY --from=wget-zstd /tmp/zstd/1.5.7/ /tmp/zstd/1.5.7/

WORKDIR /tmp/zstd/1.5.7/build/cmake/

RUN cmake \
    -DCMAKE_INSTALL_PREFIX=/opt/zstd/1.5.7 \
    -DZSTD_BUILD_SHARED=OFF \
    ./

RUN make -j $(nproc) && make install

FROM scratch AS zstd

COPY --from=build-zstd /opt/zstd/1.5.7/ /opt/zstd/1.5.7/
