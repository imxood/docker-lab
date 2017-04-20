#!/bin/bash
#
# limit.sh -- limit the network down/up speed and connections
#

[ -z "$PROXY_CONNS" ] && PROXY_CONNS=10
[ -z "$PROXY_HTTP_CONNS" ] && PROXY_HTTP_CONNS=$PROXY_CONNS
[ -z "$PROXY_SPEED" ] && PROXY_SPEED=10000
[ -z "$PROXY_DOWN_SPEED" ] && PROXY_DOWN_SPEED=$PROXY_SPEED
[ -z "$PROXY_UP_SPEED" ] && PROXY_UP_SPEED=$PROXY_SPEED
[ -z "$PROXY_LIMIT" ] && PROXY_LIMIT=1
[ -z "$PROXY_PING_LIMIT" ] && PROXY_PING_LIMIT=$PROXY_LIMIT
[ -z "$PROXY_CONNS_LIMIT" ] && PROXY_CONNS_LIMIT=$PROXY_LIMIT
[ -z "$PROXY_SPEED_LIMIT" ] && PROXY_SPEED_LIMIT=$PROXY_LIMIT
[ -z "$PROXY_DOWN_LIMIT" ] && PROXY_DOWN_LIMIT=$PROXY_SPEED_LIMIT
[ -z "$PROXY_UP_LIMIT" ] && PROXY_UP_LIMIT=$PROXY_SPEED_LIMIT

# Drop ping packages
if [ $PROXY_PING_LIMIT -eq 1 ]; then
	echo 1 > /proc/sys/net/ipv4/icmp_echo_ignore_all

	iptables -I INPUT -p icmp --icmp-type 8 -s 0/0 -j DROP
	iptables -I FORWARD -p icmp --icmp-type 8 -s 0/0 -j DROP
	iptables -I OUTPUT -p icmp --icmp-type 8 -s 0/0 -j DROP
	iptables -I INPUT -p icmp --icmp-type 0 -s 0/0 -j DROP
	iptables -I OUTPUT -p icmp --icmp-type 0 -s 0/0 -j DROP
	iptables -I FORWARD -p icmp --icmp-type 0 -s 0/0 -j DROP
fi

# Connection limitation
if [ $PROXY_CONNS_LIMIT -eq 1 ]; then
	iptables -I FORWARD -p tcp -m connlimit --connlimit-above $PROXY_CONNS -j REJECT
	iptables -I INPUT -p tcp -m connlimit --connlimit-above $PROXY_CONNS -j REJECT
	iptables -I FORWARD -p tcp --syn --dport 80 -m connlimit --connlimit-above $PROXY_HTTP_CONNS -j REJECT
	iptables -I INPUT -p tcp --syn --dport 80 -m connlimit --connlimit-above $PROXY_HTTP_CONNS -j REJECT
fi

# Speed limitation
if [ $PROXY_SPEED_LIMIT -eq 1 ]; then
	iptables -A FORWARD -m limit --limit $PROXY_SPEED/s -j ACCEPT
	iptables -A FORWARD -j DROP

if [ $PROXY_UP_LIMIT -eq 1 ]; then
	iptables -A INPUT -p tcp ! --sport 6080 ! --dport 6080 -m limit --limit $PROXY_UP_SPEED/s -j ACCEPT
	iptables -A INPUT -p tcp ! --sport 6080 ! --dport 6080 -j DROP
fi

if [ $PROXY_DOWN_LIMIT -eq 1 ]; then
	iptables -A OUTPUT -p tcp ! --sport 6080 ! --dport 6080 -m limit --limit $PROXY_DOWN_SPEED/s -j ACCEPT
	iptables -A OUTPUT -p tcp ! --sport 6080 ! --dport 6080 -j DROP
fi

	# Speed limitation
	#tc qdisc del dev eth0 root
	#
	## download speed
	#tc qdisc add dev eth0 root handle 10: htb default 256
	#tc class add dev eth0 parent 10: classid 10:1 htb rate 100mbit ceil 100mbit
	#tc class add dev eth0 parent 10:1 classid 10:10 htb rate $PROXY_DOWN_SPEED ceil $PROXY_DOWN_SPEED prio 1
	#tc qdisc add dev eth0 parent 10:10 handle 101: sfq perturb 10
	#tc filter add dev eth0 parent 10: protocol ip prio 10 handle 1 fw classid 10:10
	#
	#iptables -t mangle -A POSTROUTING -j MARK --set-mark 1
	#
	## upload speed
	#tc qdisc del dev eth0 root
	#
	#tc qdisc add dev eth0 root handle 20: htb default 256
	#tc class add dev eth0 parent 20: classid 20:1 htb rate 100mbit ceil 100mbit
	#tc class add dev eth0 parent 20:1 classid 20:10 htb rate $PROXY_UP_SPEED ceil $PROXY_UP_SPEED prio 1
	#tc qdisc add dev eth0 parent 20:10 handle 201: sfq perturb 10
	#tc filter add dev eth0 parent 20: protocol ip prio 100 handle 2 fw classid 20:10
	#
	#iptables -t mangle -A PREROUTING -j MARK --set-mark 2
fi
