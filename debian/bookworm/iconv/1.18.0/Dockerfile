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

FROM wget AS wget-iconv

RUN mkdir -p -v /tmp/iconv/1.18.0

RUN wget -O - -q "https://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.18.tar.gz" | tar -C /tmp/iconv/1.18.0/ -o --strip-components 1 -v -x -z

FROM build AS build-iconv

COPY --from=wget-iconv /tmp/iconv/1.18.0/ /tmp/iconv/1.18.0/

WORKDIR /tmp/iconv/1.18.0/

RUN ./configure \
    --disable-shared \
    --enable-option-checking=fatal \
    --prefix=/opt/iconv/1.18.0

RUN make -j $(nproc) && make install

FROM scratch AS iconv

COPY --from=build-iconv /opt/iconv/1.18.0/ /opt/iconv/1.18.0/
