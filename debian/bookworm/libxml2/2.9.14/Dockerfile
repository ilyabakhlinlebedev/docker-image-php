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

RUN apt-get -qq -y install wget xz-utils

FROM wget AS wget-libxml2

RUN mkdir -p -v /tmp/libxml2/2.9.14

RUN wget -O - -q "https://download.gnome.org/sources/libxml2/2.9/libxml2-2.9.14.tar.xz" | tar -C /tmp/libxml2/2.9.14/ -J -o --strip-components 1 -v -x

FROM build AS build-libxml2

COPY /opt/zlib/1.2.13/ /opt/zlib/1.2.13/

COPY --from=wget-libxml2 /tmp/libxml2/2.9.14/ /tmp/libxml2/2.9.14/

WORKDIR /tmp/libxml2/2.9.14/

RUN ./configure \
    --disable-shared \
    --prefix=/opt/libxml2/2.9.14 \
    --with-zlib=/opt/zlib/1.2.13

RUN make -j $(nproc) && make install

FROM scratch AS libxml2

COPY --from=build-libxml2 /opt/libxml2/2.9.14/ /opt/libxml2/2.9.14/
