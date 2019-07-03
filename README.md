Docker-utils
==
Some handy tools for `Dockerfile`

For Alpine Linux
--

### pick-mirror.sh

Pick the fastest mirror from http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt
```dockerfile
RUN wget https://raw.githubusercontent.com/phwoolcon/docker-utils/master/alpine/pick-mirror.sh -O \
    /usr/local/bin/pick-mirror.sh; \
    chmod +x /usr/local/bin/pick-mirror.sh; \
    pick-mirror.sh v3.9; \
    apk update; apk upgrade;
```
