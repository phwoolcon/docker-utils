#!/bin/sh

[ -f /.initialied ] || {
  wget https://ghu.fishdrowned.workers.dev/phwoolcon/docker-utils/master/alpine/pick-mirror -O /pick-mirror;
  chmod +x /pick-mirror;
  /pick-mirror;
  apk update;
  apk add imagemagick-dev libpng-dev libzip-dev $PHPIZE_DEPS;
  echo | pecl install imagick;
  echo | pecl install redis;
  docker-php-ext-enable imagick redis;
  docker-php-ext-install exif gd mysqli opcache pdo_mysql zip;
  touch /.initialied;
};
php-fpm;
