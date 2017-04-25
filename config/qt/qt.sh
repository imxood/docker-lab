#!/usr/bin/env bash
set -e

# xvfb give a command `xvfb-run`,virtual X server
apt-get -y install make gcc g++ build-essential libgl1-mesa-dev xvfb

# download the installation package
wget -O installer.run http://download.qt.io/official_releases/qt/${QTM}/${QT}/qt-opensource-linux-x64-${QT}.run

chmod +x $HOME/qt/installer.run
xvfb-run $HOME/qt/installer.run --script $HOME/qt/qt-installer-noninteractive.qs

rm -f $HOME/qt/installer.run
rm -f $HOME/qt/script.qs

apt-get -y clean
apt-get -y autoremove

# qt environment variable
echo "PATH=\"/opt/qt/$QTM/gcc_64/bin:/opt/qt/Tools/QtCreator/bin:$PATH\"" >> /etc/profile