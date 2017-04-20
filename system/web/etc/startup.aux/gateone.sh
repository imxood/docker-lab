#!/bin/bash
#
# novnc.sh
#

AUTH_CONF=/etc/gateone/conf.d/20authentication.conf
TERM_CONF=/etc/gateone/conf.d/50terminal.conf

[ -z "$GATEONE_PUBLIC" ] && GATEONE_PUBLIC=0

echo "GATEONE_PUBLIC: " $GATEONE_PUBLIC
echo "GATEONE_AUTH: " $GATEONE_AUTH

if [ -n "$GATEONE_AUTH" ]; then
    sed -i -e "s%\"auth\": .*,%\"auth\": \"$GATEONE_AUTH\",%g" $AUTH_CONF
fi

if [ $GATEONE_PUBLIC -eq 1 ]; then
    sed -i -e "s%ssh_connect.py %ssh_connect.py --public %g" $TERM_CONF
fi
