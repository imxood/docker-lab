#!/usr/bin/env bash
### every exit != 0 fails the script
set -e

echo "Install Xfce4 UI components  ---!xterm"
apt-get -y update
apt-get -y install supervisor xfce4
apt-get -y install xfce4-terminal
apt-get -y remove xterm
apt-get -y purge pm-utils xscreensaver*
apt-get -y clean
apt-get -y autoremove