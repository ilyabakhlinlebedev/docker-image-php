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

FROM wget AS wget-sqlite

RUN mkdir -p -v /tmp/sqlite/3.50.4

RUN wget -O - -q "https://www.sqlite.org/2025/sqlite-autoconf-3500400.tar.gz" | tar -C /tmp/sqlite/3.50.4/ -o --strip-components 1 -v -x -z

FROM build AS build-sqlite

COPY --from=wget-sqlite /tmp/sqlite/3.50.4/ /tmp/sqlite/3.50.4/

WORKDIR /tmp/sqlite/3.50.4/

RUN ./configure \
    --disable-shared \
    --prefix=/opt/sqlite/3.50.4

RUN make -j $(nproc) && make install

FROM scratch AS sqlite

COPY --from=build-sqlite /opt/sqlite/3.50.4/ /opt/sqlite/3.50.4/
