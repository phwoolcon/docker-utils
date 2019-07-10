Docker-utils
==
Some handy tools for `Dockerfile`

For Alpine Linux
--

### pick-mirror.sh

Pick the fastest mirror from http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt
```dockerfile
ARG ALPINE_REPO=""
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master/alpine"
RUN wget ${UTILS_BASE}/pick-mirror.sh -O /usr/local/bin/pick-mirror.sh; \
    chmod +x /usr/local/bin/pick-mirror.sh; \
    pick-mirror.sh v3.9; \
    apk update; apk upgrade;
```
If you want to specify the repository, use `--build-arg ALPINE_REPO=`, e.g.:
```bash
docker build --build-arg ALPINE_REPO=http://mirrors.tuna.tsinghua.edu.cn/alpine/ .
```

### aliases.sh

```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master/alpine"
ENV ENV="/etc/profile"
RUN UTILS_BASE=https://raw.githubusercontent.com/phwoolcon/docker-utils/master/alpine; \
    wget ${UTILS_BASE}/aliases.sh -O /etc/profile.d/aliases.sh;
```

### nginx && php
```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master/alpine"
RUN apk add --no-cache bash coreutils nginx \
    php7 php7-curl php7-fileinfo php7-fpm php7-gd php7-json php7-mbstring php7-opcache php7-openssl \
    php7-pdo php7-pdo_mysql php7-pecl-redis php7-phalcon php7-simplexml php7-sodium php7-tokenizer php7-xml php7-zip \
    composer;
    wget ${UTILS_BASE}/nginx/00-log-formats.conf -O /etc/nginx/conf.d/00-log-formats.conf; \
    wget ${UTILS_BASE}/nginx/default.conf -O /etc/nginx/conf.d/default.conf; \
    echo 'error_log = /mnt/data/log/php7/error.log' > /etc/php7/php-fpm.d/00-log.conf; \
    sed -i 's|/var/log|/mnt/data/log|g' /etc/nginx/nginx.conf /etc/php7/php-fpm.d/www.conf; \
    sed -i 's|127.0.0.1:9000|0.0.0.0:9000|g' /etc/php7/php-fpm.d/www.conf; \
    sed -i 's|expose_php = On|expose_php = Off|g' /etc/php7/php.ini;
```
