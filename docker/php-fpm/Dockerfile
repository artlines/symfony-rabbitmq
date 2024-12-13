FROM php:8.1-fpm-alpine3.15
WORKDIR '/app'
RUN apk update && apk upgrade\
    && apk add --no-cache curl libbz2 php8-bz2 php8-pdo php8-pgsql php8-bcmath php8-curl bash php8-pear openssh nano supervisor autoconf gcc libzmq zeromq-dev zeromq coreutils build-base \
    libtool \
    oniguruma \
    postgresql-dev \
    libpng-dev \
    imagemagick-c++ \
    imagemagick-dev \
    libmcrypt-dev \
    libxml2-dev \
    yaml-dev \
    bzip2 \
    aspell-dev \
    autoconf \
    build-base \
    linux-headers \
    libaio-dev \
    libzip-dev \
    zlib-dev \
    git \
    subversion \
    freetype-dev \
    libjpeg-turbo-dev \
    libmcrypt-dev \
    bzip2-dev \
    libstdc++ \
    libxslt-dev \
    openldap-dev \
    hiredis-dev \
    make \
    unzip \
    ffmpeg \
    php-intl \
    wget

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN docker-php-ext-configure gd --with-freetype --with-jpeg
RUN docker-php-ext-install gd
RUN docker-php-ext-install bcmath
RUN docker-php-ext-install zip
RUN docker-php-ext-install bz2
RUN docker-php-ext-install pdo
#RUN docker-php-ext-install pdo_pgsql
RUN docker-php-ext-install mysqli pdo pdo_mysql
RUN docker-php-ext-install simplexml
RUN docker-php-ext-install opcache
RUN docker-php-ext-install sockets
RUN docker-php-ext-install intl

RUN docker-php-ext-install pcntl
RUN docker-php-ext-install xsl

RUN apk add imagemagick
RUN apk add imagemagick-dev

RUN apk add --update --no-cache autoconf g++ imagemagick-dev libtool make pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make pcre-dev

RUN touch /tmp/xdebug.log && chmod 777 /tmp/xdebug.log

RUN apk add --no-cache --virtual .build-deps $PHPIZE_DEPS \
    && pecl install xdebug-3.1.0 \
    && apk del -f .build-deps

ARG XDEBUG_CLIENT_HOST=172.26.0.1
ARG XDEBUG_CLIENT_PORT=9000

RUN echo "xdebug.start_with_request=yes" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.mode=develop,debug,coverage" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.log=/tmp/xdebug.log" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_host=${XDEBUG_CLIENT_HOST}" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.extended_info=0" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.client_port=${XDEBUG_CLIENT_PORT}" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.max_nesting_level=8000" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo "xdebug.remote_handler=dbgp" >> /usr/local/etc/php/conf.d/xdebug.ini \
    && echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so' >> /usr/local/etc/php/php.ini \
    && echo 'zend_extension = /usr/local/lib/php/extensions/no-debug-non-zts-20210902/xdebug.so' >> /etc/php8/php.ini
EXPOSE 22

