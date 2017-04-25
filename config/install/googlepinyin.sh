#!/usr/bin/env bash
set -e

apt-get -y update
apt-get -y install fcitx fcitx-googlepinyin im-config
apt-get -y install ttf-wqy-microhei ttf-wqy-zenhei

apt-get -y clean
apt-get -y autoremove