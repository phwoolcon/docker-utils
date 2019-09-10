#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

function main() {
    detectAndInstallDocker
    (askEnvConfig)
    runServices
}

function detectAndInstallDocker() {
    which docker-compose > /dev/null && return
    apt-get update
    apt-get remove -y docker docker-engine docker.io containerd runc
    apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        > /etc/apt/sources.list.d/docker.list
    apt-get update
    apt-get install -y containerd.io docker-ce-cli docker-ce docker-compose
}

function askEnvConfig() {
    touch ./.env
    . ./.env
    KEYS=($(awk -F "=" '{print $1}' ./.env.example))
    for KEY in "${KEYS[@]}"; do
        askForEnv ${KEY}
    done
}

function askForEnv() {
    FILE_VAL=${!1}
    [[ -z ${FILE_VAL} ]] || return
    read -p "$1: " READ_VAL
    echo $1=${READ_VAL} >> ./.env
}

function runServices() {
    docker-compose up -d --build && docker image prune -f
    docker-compose ps
}

main
