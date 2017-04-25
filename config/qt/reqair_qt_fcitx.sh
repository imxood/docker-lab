#!/bin/bash
set -e

apt-get install -y fcitx-frontend-qt5

mkdir -p /opt/qt/Tools/QtCreator/bin/plugins/platforminputcontexts

cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so /opt/qt/Tools/QtCreator/lib/Qt/plugins/platforminputcontexts/

cp /usr/lib/x86_64-linux-gnu/qt5/plugins/platforminputcontexts/libfcitxplatforminputcontextplugin.so /opt/qt/$QTM/gcc_64/plugins/platforminputcontexts/

apt-get -y clean
apt-get -y autoremove