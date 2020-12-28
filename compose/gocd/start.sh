#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

mkdir -p data/{server,agent,.ssh}
chown 1000:1000 data/*
touch .env.local
set -a
. .env
. .env.local
set +a
docker-compose up -d
docker-compose exec --user root server bash /init-alpine.sh
docker-compose exec --user root agent bash /init-alpine.sh
docker-compose exec --user root agent apk add docker rsync
