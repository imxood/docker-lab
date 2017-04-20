#!/bin/bash
#
# generate-vnc-tokens.sh -- Generate the "token: vnc-ip:vnc-port" map file
#
#   TODO: Use vnc-ip:vnc-port directly?
#
# By default, generate the token via md5sum the 'ip:port' string.
#

[ -z "$DEFAULT_GW" ] && DEFAULT_GW=$(route -n | grep "^0.0.0.0" | tr -s ' ' | cut -d' ' -f2)
[ -z "$ENCRYPT_CMD" ] && ENCRYPT_CMD=md5sum

ipaddr=`ifconfig | grep "inet addr" | sed -e "s/ *inet addr:\([0-9\.]*\) .*/\1/g" | head -1`

port=5900
net=$(echo $DEFAULT_GW | cut -d'.' -f1-3)

tokens_dir=/vnc-tokens/
local_map=$tokens_dir/local_map
remote_map=$tokens_dir/remote_map
[ ! -d $tokens_dir ] && mkdir -p $tokens_dir

for i in `seq 1 255`; do
    ip=$net.$i
    #token=$i; echo "$token: $ip_port"
    token=$(echo -n $ip | $ENCRYPT_CMD | cut -d' ' -f1); echo "$token: $ip:$port"
done | tee $local_map

ip=$ipaddr
for port in `seq 5000 5900`; do
    #token=$i; echo "$token: $ip_port"
    token=$(echo -n $port | $ENCRYPT_CMD | cut -d' ' -f1); echo "$token: $ip:$port"
done | tee $remote_map
