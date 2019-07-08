#!/usr/bin/env sh

VERSION=${1:-latest-stable}

main() {
    if [ -n "${ALPINE_REPO}" ]; then
        save_repo ${ALPINE_REPO} ${VERSION}
    else
        run_detect
    fi
}

run_detect() {
    echo Detecting fastest mirror for alpine ${VERSION} in 2 seconds...
    > ping.log
    > ping.error.log
    wget -O- http://dl-cdn.alpinelinux.org/alpine/MIRRORS.txt 2>/dev/null | while read URL; do
        { detect ${URL} >> ping.log; } &
        { sleep .3; detect ${URL} >> ping.log; } &
        { sleep .6; detect ${URL} >> ping.log; } &
    done;
    sleep 2;
    REPO=$(awk '{SUM[$2] += $1; COUNT[$2]++};
    END {
        for (k in SUM) {
            print SUM[k] / COUNT[k], k, COUNT[k]
        }
    }' ping.log | sort -n | head -n1 | awk '{print $2}');
    save_repo ${REPO} ${VERSION}
}

request() {
    wget $1 -O /dev/null 2>>ping.error.log;
}

timestamp() {
    awk '{print $1*1000}' /proc/uptime;
}

detect() {
    START=$(timestamp)
    request $1 || exit
    END=$(timestamp)
    echo $(($END-$START)) $1 ${START} ${END};
}

save_repo() {
    echo $1
    printf "$1$2/main
$1$2/community\n" > /etc/apk/repositories
}

main
