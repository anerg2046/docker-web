#!/bin/sh
/sbin/ip route|awk '/default/ {print $3,"\tdockerhost"}' >> /etc/hosts