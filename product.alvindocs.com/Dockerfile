ARG PHP_VERSION=8.0-fpm

# STAGE [1] ==============================
FROM php:${PHP_VERSION} as php_laravel

# Install dependencies
RUN apt-get update && apt-get install -y \
  build-essential \
  libpng-dev \
  libjpeg62-turbo-dev \
  libfreetype6-dev \
  locales \
  zip \
  libonig-dev \
  libzip-dev \
  jpegoptim optipng pngquant gifsicle \
  ca-certificates \
  vim \
  tmux \
  unzip \
  git \
  cron \
  supervisor \
  curl \
  libmcrypt-dev

# Clear cache
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Install extensions
RUN pecl install mcrypt-1.0.4 && \
  docker-php-ext-install fileinfo exif pcntl bcmath gd mysqli pdo_mysql && \
  docker-php-ext-enable mcrypt

# Install composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Set working directory
WORKDIR /var/www/app

# STAGE [2] ==============================
FROM php_laravel as app
ENV APP_SOURCE /var/www/app
ENV APP_DEBUG=false
ENV APP_URL=""
ENV APP_ENV=production
ENV DB_CONNECTION=mysql
ENV DB_HOST=localhost
ENV DB_PORT=3306
ENV DB_DATABASE=laravel
ENV DB_USERNAME=laravel
ENV DB_PASSWORD=laravel

# Copy source code
COPY ./src .

# Copy PHP local.ini
COPY ./php/local.ini /usr/local/etc/php/conf.d/local.ini

# Give full accessc
RUN mkdir -p public/storage && \
  chmod -R 777 storage/* && \
  chmod -R 777 public/storage

# Install dependency laravel
RUN php -r "file_exists('.env') || copy('.env.example', '.env');" && \
  composer install --no-interaction --optimize-autoloader --no-dev && \
  php artisan package:discover --ansi && \
  php artisan key:generate --ansi --force

# Set Volume
VOLUME ${APP_SOURCE}/storage

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]