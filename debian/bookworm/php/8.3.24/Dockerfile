FROM debian:bookworm AS base

ARG DEBIAN_FRONTEND="noninteractive"

RUN apt-get -qq -y update && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y dist-upgrade && \
    apt-get -qq -y clean && \
    apt-get -qq -y autoclean && \
    apt-get -qq -y autoremove

FROM base AS build

RUN apt-get -qq -y install autoconf bison build-essential pkg-config re2c

FROM base AS wget

RUN apt-get -qq -y install wget

FROM wget AS wget-composer

RUN wget -O /tmp/composer-installer.php "https://getcomposer.org/installer"

FROM wget AS wget-php

RUN mkdir -p -v /tmp/php/8.3.24

RUN wget -O - -q "https://www.php.net/distributions/php-8.3.24.tar.gz" | tar -C /tmp/php/8.3.24/ -o --strip-components 1 -v -x -z

FROM build AS build-php

COPY /opt/brotli/1.1.0/ /opt/brotli/1.1.0/
COPY /opt/curl/7.88.1/ /opt/curl/7.88.1/
COPY /opt/iconv/1.18.0/ /opt/iconv/1.18.0/
COPY /opt/icu/77.1.0/ /opt/icu/77.1.0/
COPY /opt/libxml2/2.9.14/ /opt/libxml2/2.9.14/
COPY /opt/libzip/1.11.4/ /opt/libzip/1.11.4/
COPY /opt/oniguruma/6.9.10/ /opt/oniguruma/6.9.10/
COPY /opt/openssl/3.0.16/ /opt/openssl/3.0.16/
COPY /opt/ncurses/6.5.0/ /opt/ncurses/6.5.0/
COPY /opt/readline/8.2.0/ /opt/readline/8.2.0/
COPY /opt/sqlite/3.50.4/ /opt/sqlite/3.50.4/
COPY /opt/zlib/1.2.13/ /opt/zlib/1.2.13/
COPY /opt/zstd/1.5.7/ /opt/zstd/1.5.7/

COPY --from=wget-php /tmp/php/8.3.24/ /tmp/php/8.3.24/

WORKDIR /tmp/php/8.3.24/

ARG CFLAGS="-I/opt/brotli/1.1.0/include -I/opt/iconv/1.18.0/include -I/opt/ncurses/6.5.0/include -I/opt/readline/8.2.0/include -I/opt/zstd/1.5.7/include"
ARG LDFLAGS="-L/opt/brotli/1.1.0/lib -L/opt/iconv/1.18.0/lib -L/opt/ncurses/6.5.0/lib -L/opt/readline/8.2.0/lib -L/opt/zstd/1.5.7/lib"
ARG LIBS="-l:libbrotlicommon.a -l:libbrotlidec.a -l:libbrotlienc.a -l:libcharset.a -l:libform.a -l:libhistory.a -l:libiconv.a -l:libmenu.a -l:libncurses.a -l:libpanel.a -l:libreadline.a -l:libzstd.a"
ARG LIBZIP_CFLAGS="-I/opt/libzip/1.11.4/include"
ARG LIBZIP_LIBS="-L/opt/libzip/1.11.4/lib -l:libzip.a"
ARG ONIG_CFLAGS="-I/opt/oniguruma/6.9.10/include"
ARG ONIG_LIBS="-L/opt/oniguruma/6.9.10/lib -l:libonig.a"
ARG PKG_CONFIG_PATH="/opt/curl/7.88.1/lib/pkgconfig:/opt/icu/77.1.0/lib/pkgconfig:/opt/libxml2/2.9.14/lib/pkgconfig:/opt/openssl/3.0.16/lib64/pkgconfig"
ARG SQLITE_CFLAGS="-I/opt/sqlite/3.50.4/include"
ARG SQLITE_LIBS="-L/opt/sqlite/3.50.4/lib -l:libsqlite3.a"
ARG ZLIB_CFLAGS="-I/opt/zlib/1.2.13/include"
ARG ZLIB_LIBS="-L/opt/zlib/1.2.13/lib -l:libz.a"

RUN ./configure \
    --disable-all \
    --disable-cgi \
    --disable-phpdbg \
    --disable-shared \
    --disable-short-tags \
    --enable-bcmath \
    --enable-calendar \
    --enable-ctype \
    --enable-dom \
    --enable-exif \
    --enable-fileinfo \
    --enable-filter \
    --enable-fpm \
    --enable-ftp \
    --enable-intl \
    --enable-ipv6 \
    --enable-libgcc \
    --enable-mbstring \
    --enable-option-checking=fatal \
    --enable-pdo \
    --enable-phar \
    --enable-session \
    --enable-static \
    --enable-tokenizer \
    --enable-xml \
    --enable-xmlreader \
    --enable-xmlwriter \
    --prefix=/opt/PHP/8.3.24 \
    --with-config-file-path=/opt/PHP/8.3.24/etc \
    --with-config-file-scan-dir=/opt/PHP/8.3.24/etc/ext \
    --with-curl \
    --with-fpm-group=www-data \
    --with-fpm-user=www-data \
    --with-gnu-ld \
    --with-iconv=/opt/iconv/1.18.0 \
    --with-libxml \
    --with-openssl \
    --with-openssl-dir \
    --with-pdo-sqlite \
    --with-readline=/opt/readline/8.2.0 \
    --with-sqlite3 \
    --with-zip \
    --with-zlib

RUN make -j $(nproc) && make install

FROM build AS install-php

COPY --from=build-php /opt/PHP/8.3.24/ /opt/PHP/8.3.24/
COPY --from=wget-composer /tmp/composer-installer.php /tmp/composer-installer.php

RUN /opt/PHP/8.3.24/bin/php /tmp/composer-installer.php --filename=composer --install-dir=/opt/PHP/8.3.24/bin/

FROM install-php AS install-php-dev

COPY --from=wget-php /tmp/php/8.3.24/php.ini-development /opt/PHP/8.3.24/etc/php.ini

FROM install-php AS install-php-pro

COPY --from=wget-php /tmp/php/8.3.24/php.ini-production /opt/PHP/8.3.24/etc/php.ini

FROM debian:bookworm AS php-dev

COPY --from=install-php-dev /opt/PHP/8.3.24/ /opt/PHP/8.3.24/

FROM debian:bookworm AS php-pro

COPY --from=install-php-pro /opt/PHP/8.3.24/ /opt/PHP/8.3.24/
