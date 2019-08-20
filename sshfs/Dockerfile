FROM alpine:3.10

ARG ALPINE_REPO=""
ARG UTILS_BASE="https://raw.githubusercontent.com/phwoolcon/docker-utils/master"
ENV ENV="/etc/profile"
RUN wget ${UTILS_BASE}/alpine/aliases.sh -O /etc/profile.d/aliases.sh; \
    wget ${UTILS_BASE}/alpine/pick-mirror -O /usr/local/bin/pick-mirror; \
    wget ${UTILS_BASE}/dusort -O /usr/local/bin/dusort; \
    chmod +x /usr/local/bin/*; \
    pick-mirror v3.10; \
    apk update; apk upgrade; \
    apk add --no-cache bash coreutils openssh; \
    addgroup sshfs;
COPY . /
VOLUME /data
EXPOSE 22
ENTRYPOINT ["/entrypoint.sh"]
