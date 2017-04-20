#!/bin/bash
#
# nossl.sh -- Disable ssl feature for gateone/vnc?
#

[ -z "$NOSSL" ] && NOSSL=0

if [ $NOSSL -eq 1 ]; then
    sed -i -e 's%"disable_ssl":.*,%"disable_ssl": true,%g' /etc/gateone/conf.d/10server.conf

    mv /etc/nginx/sites-enabled/nossl /etc/nginx/sites-enabled/default
else
    sed -i -e 's%"disable_ssl":.*,%"disable_ssl": false,%g' /etc/gateone/conf.d/10server.conf

    rm /etc/nginx/sites-enabled/nossl
fi
