#!/usr/bin/env bash

mkdir -p /data/etc/ssh /data/etc/fstab /data/log /data/users /data/share /data/depts /sshfs;
ssh-keygen -A -f /data;

[[ -f /data/etc/group ]] || cp -a /etc/group /data/etc/group
[[ -f /data/etc/passwd ]] || cp -a /etc/passwd /data/etc/passwd
[[ -f /data/etc/shadow ]] || cp -a /etc/shadow /data/etc/shadow
cp /data/etc/group /etc/group
cp /data/etc/passwd /etc/passwd
cp /data/etc/shadow /etc/shadow
sf_gen_fstab_and_mount;

umask 002
chgrp sshfs /data/depts
chmod g+w /data/depts
chmod g+s /data/depts

chgrp sshfs /data/share
chmod g+w /data/share
chmod g+s /data/share
/usr/sbin/sshd -D -E /data/log/sshd.log;
