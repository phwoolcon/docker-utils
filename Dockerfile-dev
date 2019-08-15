FROM phwoolcon/phwoolcon

ARG ALPINE_REPO=""
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
RUN pick-mirror v3.9; \
    apk add --no-cache vim shadow curl htop iftop iotop php7-pecl-xdebug; \
    wget ${UTILS_BASE}/dusort -O /usr/local/bin/dusort; \
    chmod +x /usr/local/bin/dusort; \
    echo "zend_extension=xdebug.so" > /etc/php7/conf.d/xdebug.ini; \
    php --ri xdebug;
COPY copy /
VOLUME /srv/http
