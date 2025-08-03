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

FROM wget AS wget-readline

RUN mkdir -p -v /tmp/readline/8.2.0

RUN wget -O - -q "https://ftp.gnu.org/gnu/readline/readline-8.2.tar.gz" | tar -C /tmp/readline/8.2.0/ -o --strip-components 1 -v -x -z

FROM build AS build-readline

COPY /opt/ncurses/6.5.0/ /opt/ncurses/6.5.0/

COPY --from=wget-readline /tmp/readline/8.2.0/ /tmp/readline/8.2.0/

WORKDIR /tmp/readline/8.2.0/

ARG CFLAGS="-I/opt/ncurses/6.5.0/include"
ARG LDFLAGS="-L/opt/ncurses/6.5.0/lib"
ARG LIBS="-l:libform.a -l:libmenu.a -l:libncurses.a -l:libpanel.a"

RUN ./configure \
    --disable-shared \
    --prefix=/opt/readline/8.2.0 \
    --with-curses

RUN make -j $(nproc) && make install

FROM scratch AS readline

COPY --from=build-readline /opt/readline/8.2.0/ /opt/readline/8.2.0/
