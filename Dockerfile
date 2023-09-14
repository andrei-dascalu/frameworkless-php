FROM php:8.2-cli-alpine

WORKDIR /application

COPY ./.setup/setup.rr.sh .
COPY ./.setup/setup.composer.sh .

RUN apk update && apk add --no-cache --no-progress --virtual .build-deps \
        git \
        make \
        automake \
        libmcrypt-dev \
        g++ \
        autoconf \
        pkgconfig \
        freetype-dev \
        musl-dev \
        gcc \
        file \
        linux-headers \
        oniguruma-dev \
        libxml2-dev \
        libpng-dev \
        libjpeg-turbo-dev \
        libsodium-dev \
        curl-dev \
        icu-dev \
        libzip-dev \
    && apk add --no-cache --no-progress \
        libcurl \
        wget \
        curl \
        icu-libs \
        libsodium \
        icu \
        gettext \
        oniguruma \
        zip \
        unzip \
        libmcrypt \
        zlib \
        libzip \
    && docker-php-ext-install \
        mysqli \
        bcmath \
        sodium \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        calendar \
        intl \
        zip \
    && docker-php-ext-enable \
        mysqli \
        bcmath \
        sodium \
        curl \
        mbstring \
        pdo \
        pdo_mysql \
        calendar \
        intl \
        zip \
    && pecl upgrade igbinary msgpack timezonedb \
    && docker-php-ext-enable igbinary msgpack timezonedb opcache \
    && pecl install --onlyreqdeps --nobuild redis \
    && cd "$(pecl config-get temp_dir)/redis" \
    && phpize \
    && ./configure --enable-redis-igbinary \
    && make && make install  \
    && rm -rf "$(pecl config-get temp_dir)/redis" \
    && cd /application \
    && docker-php-ext-enable redis \
    && chmod +x setup.rr.sh && ./setup.rr.sh && rm -rf ./setup.rr.sh \
    && chmod +x setup.composer.sh && ./setup.composer.sh && rm -rf ./setup.composer.sh \
    && CFLAGS="$CFLAGS -D_GNU_SOURCE" docker-php-ext-install sockets \
    && apk del .build-deps

ENTRYPOINT ["/bin/sh", "-c"]
