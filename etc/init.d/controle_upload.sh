#!/bin/bash

tc qdisc del dev eth1 root

tc qdisc add dev eth1 root handle 1:0 htb default 40
tc class add dev eth1 parent 1:0 classid 1:1 htb rate 100mbit

tc class add dev eth1 parent 1:1 classid 1:10 htb rate 100kbit ceil 300kbit prio 0   # DNS / ACK / SYN / FIN 
tc class add dev eth1 parent 1:1 classid 1:20 htb rate 500kbit ceil 500kbit prio 1   # E-mail
tc class add dev eth1 parent 1:1 classid 1:30 htb rate 300kbit ceil 500kbit prio 2   # FTP
tc class add dev eth1 parent 1:1 classid 1:40 htb rate 300kbit ceil 500kbit prio 3   # Geral