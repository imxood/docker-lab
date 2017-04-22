FROM ubuntu:xenial
MAINTAINER maxu <imxood@163.com>

ENV DEBIAN_FRONTEND noninteractive

ENV USER imxood
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

ENV NO_VNC_HOME $HOME/noVNC

### Install noVNC - HTML5 based VNC viewer
COPY config/install/no_vnc.sh $INST_SCRIPTS/no_vnc.sh
RUN $INST_SCRIPTS/no_vnc.sh

ENV STARTUPDIR /dockerstartup

### configure startup
COPY config/scripts $STARTUPDIR
COPY config/install/libnss_wrapper.sh $INST_SCRIPTS/libnss_wrapper.sh
RUN $INST_SCRIPTS/libnss_wrapper.sh

COPY config/install/set_user_permission.sh $INST_SCRIPTS/set_user_permission.sh
RUN $INST_SCRIPTS/set_user_permission.sh $STARTUPDIR $HOME

RUN apt-get install -y --no-install-recommends xauth

## Connection ports for controlling the UI:
# VNC port:5901
# noVNC webport, connect via http://localhost:6901/?password=vncpassword
ENV DISPLAY :1
ENV VNC_PORT 5901
ENV NO_VNC_PORT 6901
EXPOSE $VNC_PORT $NO_VNC_PORT

### Envrionment config
ENV VNC_COL_DEPTH 24
ENV VNC_RESOLUTION 1280x1024
ENV VNC_PW vncpassword

COPY config/xterm/.Xdefaults $HOME/.Xdefaults

USER 1984

CMD ["/dockerstartup/vnc_startup.sh", "--tail-log"]

# RUN echo "admin:admin" | chpasswd && echo "admin   ALL=(ALL)       ALL" >> /etc/sudoers
# RUN echo "Ciphers aes128-cbc,aes192-cbc,aes256-cbc,blowfish-cbc,arcfour" >> /etc/ssh/sshd_config && echo "KexAlgorithms diffie-hellman-group1-sha1" >> /etc/ssh/sshd_config