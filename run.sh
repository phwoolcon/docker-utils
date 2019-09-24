#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

function main() {
    detectAndInstallDocker
    (askEnvConfig)
    changeBareMetalSshPort
    runServices
}

function detectAndInstallDocker() {
    which docker-compose > /dev/null && return
    sudo apt-get update
    sudo apt-get remove -y docker docker-engine docker.io containerd runc
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
    echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" \
        | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    sudo apt-get install -y containerd.io docker-ce-cli docker-ce docker-compose
}

function askEnvConfig() {
    touch ./.env
    . ./.env
    KEYS=($(awk -F "=" '{print $1}' ./.env.example))
    echo Setting SSHFS environment...
    for KEY in "${KEYS[@]}"; do
        askForEnv ${KEY}
    done
    echo Done
}

function askForEnv() {
    FILE_VAL=${!1}
    [[ -z ${FILE_VAL} ]] || return
    read -p "$1: " READ_VAL
    echo $1=${READ_VAL} >> ./.env
}

function changeBareMetalSshPort() {
    grep -P '^Port\s+22$' /etc/ssh/sshd_config > /dev/null && sudo sed -Ei 's|^Port\s+22$|#Port 22|g'
    grep -P '^Port\s\d+\s+# sshfs$' /etc/ssh/sshd_config > /dev/null && return
    read -p "Change the SSH port of the bare metal server: " SSH_PORT
    echo "Port ${SSH_PORT} # sshfs" | sudo tee -a /etc/ssh/sshd_config > /dev/null
    sudo service ssh restart
}

function runServices() {
    [[ -d .git ]] && git pull
    sudo docker-compose pull
    sudo docker-compose up -d --build
    sudo docker image prune -f
    sudo docker-compose ps
}

main
