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

FROM wget AS wget-ncurses

RUN mkdir -p -v /tmp/ncurses/6.5.0

RUN wget -O - -q "https://ftp.gnu.org/gnu/ncurses/ncurses-6.5.tar.gz" | tar -C /tmp/ncurses/6.5.0/ -o --strip-components 1 -v -x -z

FROM build AS build-ncurses

COPY --from=wget-ncurses /tmp/ncurses/6.5.0/ /tmp/ncurses/6.5.0/

WORKDIR /tmp/ncurses/6.5.0/

RUN ./configure \
    --disable-lib-suffixes \
    --prefix=/opt/ncurses/6.5.0 \
    --without-debug

RUN make -j $(nproc) && make install

FROM scratch AS ncurses

COPY --from=build-ncurses /opt/ncurses/6.5.0/ /opt/ncurses/6.5.0/
