FROM php:7.3-fpm

RUN apt-get -qq update && apt-get -qq install -y \
    $PHPIZE_DEPS \
    bash \
    libmcrypt-dev \
    libpq-dev \
    libwebp-dev \
    libpng-dev \
    libzip-dev \
    libjpeg-dev \
    nano \
    openssl \
    postgresql \
    sqlite \
    sudo \
    unzip \
    vim \
    wget \
    zip

RUN pecl install xdebug-2.7.1 \
    && docker-php-ext-enable xdebug

RUN docker-php-ext-configure gd \
    --with-gd \
    --with-png-dir=/usr/include/ \
    --with-webp-dir=/usr/include/ \
    --with-jpeg-dir=/usr/include/

RUN docker-php-ext-install \
    zip \
    pdo \
    pdo_pgsql \
    mbstring \
    tokenizer \
    bcmath \
    pcntl \
    gd

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin/ --filename=composer

RUN apt-get clean

RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /var/cache/*

WORKDIR /app
