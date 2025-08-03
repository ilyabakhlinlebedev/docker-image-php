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

FROM wget AS wget-zlib

RUN mkdir -p -v /tmp/zlib/1.2.13

RUN wget -O - -q "https://zlib.net/fossils/zlib-1.2.13.tar.gz" | tar -C /tmp/zlib/1.2.13/ -o --strip-components 1 -o -v -x -z

FROM build AS build-zlib

COPY --from=wget-zlib /tmp/zlib/1.2.13/ /tmp/zlib/1.2.13/

WORKDIR /tmp/zlib/1.2.13/

RUN ./configure \
    --prefix=/opt/zlib/1.2.13 \
    --static

RUN make -j $(nproc) && make install

FROM scratch AS zlib

COPY --from=build-zlib /opt/zlib/1.2.13/ /opt/zlib/1.2.13/
