#!/bin/bash
set -e

#generate language config
apt-get -y install locales
locale-gen $LANG
dpkg-reconfigure locales