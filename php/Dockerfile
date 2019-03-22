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
    # 安装composer
    curl -sS https://getcomposer.org/installer | php \
    mv composer.phar /usr/local/bin/composer \
    composer config -g repo.packagist composer https://packagist.laravel-china.org \
    # opencc 依赖
    gcc \
    cmake \
    doxygen \
    python \
    git \
    # 进入临时目录 准备opencc
    && cd /tmp \
    && git clone https://github.com/BYVoid/OpenCC.git --depth 1 \
    && cd OpenCC \
    && make -j$(nproc) \
    && make install \
    && cd .. \
    && git clone https://github.com/NauxLiu/opencc4php.git --depth 1 \
    && docker-php-ext-configure /tmp/opencc4php \
    && docker-php-ext-install -j$(nproc) /tmp/opencc4php \
    && cd .. \
    # opencc 安装完毕
    # 安装GD
    && docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include \
    --with-png-dir=/usr/include \
    --with-jpeg-dir=/usr/include \
    # 安装一些扩展
    && docker-php-ext-install -j$(nproc) opcache pdo_mysql bcmath gd \
    # 安装memcached扩展
    && pecl install memcached-3.1.3 \
    && docker-php-ext-enable memcached \
    # 安装redis扩展
    && pecl install redis-4.2.0 \
    && docker-php-ext-enable redis \
    && mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini" \
    && apk del .build-deps \
    && rm -rf /tmp/* /usr/local/lib/php/doc/* /var/cache/apk/* /usr/src/* /usr/share/opencc/doc/* \
    && docker-php-source delete

COPY www.conf /usr/local/etc/php-fpm.d/