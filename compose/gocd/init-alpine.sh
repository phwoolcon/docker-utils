which pick-mirror && exit
UTILS_BASE="https://ghu.fishdrowned.workers.dev/phwoolcon/docker-utils/master"
wget ${UTILS_BASE}/alpine/pick-mirror -O /usr/local/bin/pick-mirror
wget ${UTILS_BASE}/dusort -O /usr/local/bin/dusort
wget ${UTILS_BASE}/docker-host -O /usr/local/bin/docker-host
wget ${UTILS_BASE}/alpine/aliases.sh -O /etc/profile.d/aliases.sh
chmod +x /usr/local/bin/*
pick-mirror
