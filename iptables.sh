#!/usr/bin/env bash

ipset -N redir iphash
iptables -t nat -A PREROUTING -p tcp -m set --match-set redir dst -j REDIRECT --to-port 1080
