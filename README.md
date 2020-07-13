Docker-utils
==
Some handy tools for `Dockerfile`

For Alpine Linux
--

### pick-mirror

Pick the fastest mirror from http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt
```dockerfile
ARG ALPINE_REPO=""
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN wget ${UTILS_BASE}/alpine/pick-mirror -O /usr/local/bin/pick-mirror; \
    chmod +x /usr/local/bin/*; \
    pick-mirror; \
    apk update; apk upgrade;
```
If you want to specify the repository, use `--build-arg ALPINE_REPO=`, e.g.:
```bash
docker build --build-arg ALPINE_REPO=http://mirrors.tuna.tsinghua.edu.cn/alpine/ .
```

### aliases.sh

```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
ENV ENV="/etc/profile"
RUN wget ${UTILS_BASE}/alpine/aliases.sh -O /etc/profile.d/aliases.sh;
```

### nginx && php
```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN apk add --no-cache bash coreutils nginx \
    php7 php7-curl php7-fileinfo php7-fpm php7-gd php7-json php7-mbstring php7-opcache php7-openssl \
    php7-pdo php7-pdo_mysql php7-pecl-redis php7-phalcon php7-simplexml php7-sodium php7-tokenizer php7-xml php7-zip \
    composer;
    wget ${UTILS_BASE}/alpine/determine-fpm-workers -O /usr/local/bin/determine-fpm-workers; \
    chmod +x /usr/local/bin/*; \
    wget ${UTILS_BASE}/alpine/nginx/00-log-formats.conf -O /etc/nginx/conf.d/00-log-formats.conf; \
    wget ${UTILS_BASE}/alpine/nginx/default.conf -O /etc/nginx/conf.d/default.conf; \
    echo 'error_log = /mnt/data/log/php7/error.log' > /etc/php7/php-fpm.d/00-log.conf; \
    sed -i 's|/var/log|/mnt/data/log|g' /etc/nginx/nginx.conf /etc/php7/php-fpm.d/www.conf; \
    sed -i 's|127.0.0.1:9000|0.0.0.0:9000|g' /etc/php7/php-fpm.d/www.conf; \
    sed -i 's|expose_php = On|expose_php = Off|g' /etc/php7/php.ini;
```

## Phwoolcon on docker hub
https://hub.docker.com/u/phwoolcon
```bash
docker build --no-cache -t phwoolcon/phwoolcon -f phwoolcon/Dockerfile-prod phwoolcon/
docker build --no-cache -t phwoolcon/phwoolcon-dev -f phwoolcon/Dockerfile-dev phwoolcon/
```

Common Tools
--

### dusort
Sorted version of `du`, skipped directories on different file systems.

```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN wget ${UTILS_BASE}/dusort -O /usr/local/bin/dusort; \
    chmod +x /usr/local/bin/*;
```

### docker-host
Get the IP address of the docker host

```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN wget ${UTILS_BASE}/docker-host -O /usr/local/bin/docker-host; \
    chmod +x /usr/local/bin/*;
```

### in-docker
Check if the current script is running in a docker container

```dockerfile
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN wget ${UTILS_BASE}/in-docker -O /usr/local/bin/in-docker; \
    chmod +x /usr/local/bin/*; \
    in-docker && run-your-command;
```
