#!/usr/bin/env bash
set -e

# xvfb give a command `xvfb-run`,virtual X server
apt-get -y install make gcc g++ build-essential libgl1-mesa-dev xvfb

# download the installation package
#wget -O installer.run http://download.qt.io/official_releases/qt/${QTM}/${QT}/qt-opensource-linux-x64-${QT}.run

chmod +x /install_files/qt/installer.run
xvfb-run /install_files/qt/installer.run --script /install_files/qt/qt-installer-noninteractive.qs

# qt environment variable
echo "PATH=\"/opt/qt/$QTM/gcc_64/bin:/opt/qt/Tools/QtCreator/bin:$PATH\"" >> /etc/profile

apt-get -y install fcitx-frontend-qt5

cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/* /opt/qt/5.7/gcc_64/plugins/platforminputcontexts
cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/* /opt/qt/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts

apt-get -y clean
apt-get -y autoremove