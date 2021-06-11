#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE[0]}")"

sudo useradd -m git
sudo -u git ssh-keygen -t rsa -b 4096 -C "Gitea Host Key" -f /home/git/.ssh/id_rsa -qN ""
sudo -u git touch /home/git/.ssh/authorized_keys
sudo -u git chmod 600 /home/git/.ssh/authorized_keys
sudo -u git grep -f /home/git/.ssh/id_rsa.pub /home/git/.ssh/authorized_keys || {
  sudo -u git cat /home/git/.ssh/id_rsa.pub | sudo -u git tee -a /home/git/.ssh/authorized_keys
}
sudo mkdir -p /app/gitea/
sudo cp app/gitea/gitea /app/gitea/gitea
