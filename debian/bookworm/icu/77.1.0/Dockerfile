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

FROM wget AS wget-icu

RUN mkdir -p -v /tmp/icu/77.1.0

RUN wget -O - -q "https://github.com/unicode-org/icu/releases/download/release-77-1/icu4c-77_1-src.tgz" | tar -C /tmp/icu/77.1.0/ -o --strip-components 1 -v -x -z

FROM build AS build-icu

COPY --from=wget-icu /tmp/icu/77.1.0/ /tmp/icu/77.1.0/

WORKDIR /tmp/icu/77.1.0/source/

RUN ./configure \
    --disable-shared \
    --enable-option-checking=fatal \
    --enable-static \
    --prefix=/opt/icu/77.1.0

RUN make -j $(nproc) && make install

FROM scratch AS icu

COPY --from=build-icu /opt/icu/77.1.0/ /opt/icu/77.1.0/
