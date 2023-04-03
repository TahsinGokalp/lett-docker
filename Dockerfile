FROM php:8.2-fpm-alpine

RUN apt-get update && \
    apt-get install -y \
        git \
        unzip \
        libonig-dev \
        libxml2-dev \
        libzip-dev \
        zip

RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd xml zip && \
    pecl install redis && docker-php-ext-enable redis

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

RUN git clone --branch master https://github.com/TahsinGokalp/lett-tracker.git /var/www \
    && chown -R www-data:www-data /var/www

RUN chown -R www-data:www-data /var/www

EXPOSE 9000
CMD ["php-fpm"]