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

FROM wget AS wget-oniguruma

RUN mkdir -p -v /tmp/oniguruma/6.9.10

RUN wget -O - -q "https://github.com/kkos/oniguruma/releases/download/v6.9.10/onig-6.9.10.tar.gz" | tar -C /tmp/oniguruma/6.9.10/ -o --strip-components 1 -o -v -x -z

FROM build AS build-oniguruma

COPY --from=wget-oniguruma /tmp/oniguruma/6.9.10/ /tmp/oniguruma/6.9.10/

WORKDIR /tmp/oniguruma/6.9.10/

RUN ./configure \
    --disable-shared \
    --enable-option-checking=fatal \
    --prefix=/opt/oniguruma/6.9.10

RUN make -j $(nproc) && make install

FROM scratch AS oniguruma

COPY --from=build-oniguruma /opt/oniguruma/6.9.10/ /opt/oniguruma/6.9.10/
