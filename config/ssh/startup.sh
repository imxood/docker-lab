#!/bin/bash

id -u ubuntu &>/dev/null || useradd --create-home --shell /bin/bash --user-group --groups adm,sudo ubuntu

[ -d /home/ubuntu ] && chown ubuntu:ubuntu -R /home/ubuntu/

[ -z "$UNIX_PWD" ] && UNIX_PWD=ubuntu

/bin/echo "ubuntu:$UNIX_PWD" | /usr/sbin/chpasswd

# /tmp
mount -t tmpfs none /tmp

for f in /etc/startup.aux/*.sh
do
    . $f
done

echo "start----supervisord"
/usr/bin/supervisord -n -c /etc/supervisor/supervisord.conf
