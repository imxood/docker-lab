FROM ubuntu:xenial
MAINTAINER maxu <imxood@163.com>

ENV DEBIAN_FRONTEND noninteractive

ENV HOME /imxood

ENV INST_SCRIPTS $HOME/install

COPY config/common/sources.list /etc/apt/sources.list
#COPY config/install $INST_SCRIPTS

### Install xfce UI
COPY config/install/xfce_ui.sh $INST_SCRIPTS/xfce_ui.sh
RUN $INST_SCRIPTS/xfce_ui.sh
ADD config/xfce/ $HOME/

### Install tools
COPY config/install/tools.sh $INST_SCRIPTS/tools.sh
RUN $INST_SCRIPTS/tools.sh

### Install xvnc-server
COPY config/install/tigervnc.sh $INST_SCRIPTS/tigervnc.sh
RUN $INST_SCRIPTS/tigervnc.sh

ENV QT=5.7.1
ENV QTM=5.7

COPY config/qt $HOME/qt
COPY qt-opensource-linux-x64-5.7.1.run $HOME/qt/installer.run
RUN $HOME/qt/qt.sh
RUN $HOME/qt/reqair_qt_fcitx.sh
RUN rm -rf $HOME/qt

ENV NO_VNC_HOME $HOME/noVNC

### Install noVNC - HTML5 based VNC viewer
COPY config/install/no_vnc.sh $INST_SCRIPTS/no_vnc.sh
RUN $INST_SCRIPTS/no_vnc.sh

ENV STARTUPDIR /startup

### configure startup
COPY config/scripts $STARTUPDIR

COPY config/install/googlepinyin.sh $INST_SCRIPTS/googlepinyin.sh
RUN $INST_SCRIPTS/googlepinyin.sh

COPY config/vim/.vimrc $HOME/.vimrc
COPY config/x/.xsessionrc $HOME/.xsessionrc

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://localhost:6901/?password=vncpassword
ENV DISPLAY :1
ENV VNC_PORT 5901
ENV NO_VNC_PORT 6901
EXPOSE $VNC_PORT $NO_VNC_PORT

ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1344x622
ENV VNC_PW vncpassword

CMD ["/startup/vnc_startup.sh", "--tail-log"]

ENV LANG zh_CN.UTF-8
COPY config/install/locales.sh $HOME/locales.sh
RUN $HOME/locales.sh

# RUN echo "admin:admin" | chpasswd && echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers
# RUN echo "Ciphers aes128-cbc,aes192-cbc,aes256-cbc,blowfish-cbc,arcfour" >> /etc/ssh/sshd_config && echo "KexAlgorithms diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config