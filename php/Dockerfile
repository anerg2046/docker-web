FROM php:fpm-alpine

ENV TIMEZONE    Asia/Shanghai

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && set -xe \
    && apk -U upgrade \
    && apk add --update --no-cache \
        freetype \
        libjpeg-turbo \
        libpng \
        libmemcached-libs \
    && apk add --update --no-cache --virtual .build-deps \
        $PHPIZE_DEPS \
        freetype-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libmemcached-dev \
        libmcrypt-dev \
    && docker-php-ext-configure gd \
        --with-freetype-dir=/usr/include \
        --with-png-dir=/usr/include \
        --with-jpeg-dir=/usr/include \
    && docker-php-ext-install -j$(nproc) opcache pdo_mysql bcmath gd \
    && pecl install memcached-3.1.3 \
    && docker-php-ext-enable memcached \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/* /usr/src/* \
    && docker-php-source delete