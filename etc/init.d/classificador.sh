#!/bin/bash

PATH=/bin:/sbin:/usr/bin:/usr/sbin

iptables -t mangle -F

# portas e-mail (entrada e saida)
iptables -t mangle -A FORWARD -p tcp -m multiport --ports 25,110,995 -j CLASSIFY --set-class 1:20

# trafego HTTP entrando
iptables -t mangle -A FORWARD -o eth0 -p tcp --sport 80 -j CLASSIFY --set-class 1:30
