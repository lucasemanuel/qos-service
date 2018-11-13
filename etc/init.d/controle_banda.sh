#!/bin/bash

# remove qualquer pré-configuração existente
tc qdisc del dev eth0 root

# estabelece o root, para a interface eth0, com a designação 1:0, usando a disciplina HTB
# também estabelece que a classe default será a 1:40
tc qdisc add dev eth0 root handle 1:0 htb default 40
# estabelece que a classe 1:0 será parent (pai) da 1:1
# esta classe estabelece que a interface de rede eth0 funcionará a 100 Mb/s
tc class add dev eth0 parent 1:0 classid 1:1 htb rate 100mbit

tc class add dev eth0 parent 1:1 classid 1:10 htb rate 100kbit  ceil 300kbit  prio 0   # DNS / ACK / SYN / FIN
tc class add dev eth0 parent 1:1 classid 1:20 htb rate 500kbit  ceil 800kbit  prio 1   # E-mail
tc class add dev eth0 parent 1:1 classid 1:30 htb rate 1200kbit ceil 1600kbit prio 2   # HTTP / HTTPS
tc class add dev eth0 parent 1:1 classid 1:40 htb rate 300kbit  ceil 500kbit  prio 3   # Geral