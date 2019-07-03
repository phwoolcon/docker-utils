docker-utils
===

pick-mirror-alpine.sh
---
Pick the fastest mirror from http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt
```dockerfile
RUN wget https://raw.githubusercontent.com/phwoolcon/docker-utils/master/bin/pick-mirror-alpine.sh -O /usr/local/bin/pick-mirror-alpine.sh; \
    chmod +x /usr/local/bin/pick-mirror-alpine.sh; \
    pick-mirror-alpine.sh v3.9; \
    apk update; apk upgrade;
```
