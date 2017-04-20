FROM ubuntu:xenial
MAINTAINER maxu <imxood@163.com>

ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive

# Setup our Ubuntu sources
ADD system/base/etc/apt/sources.list /etc/apt/sources.list
RUN apt-get -y update

RUN apt-get install -y --force-yes --no-install-recommends \
	supervisor \
	vim-tiny \
	xfce4 xfce4-goodies x11vnc xvfb \
	openssh-server \
	&& mkdir /var/run/sshd

RUN apt-get install -y --force-yes --no-install-recommends  gcc g++

# pip
RUN apt-get install -y --force-yes --no-install-recommends wget \
	&& wget --no-check-certificate https://bootstrap.pypa.io/get-pip.py \
	&& python get-pip.py \
	&& rm -f get-pip.py

# Web SSH
RUN apt-get install -y --force-yes --no-install-recommends python-pip dtach \
	openssh-client telnet \
    && pip install gateone \
    && mkdir -p /etc/gateone/ssl/ \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/cache/apt/archives/*.deb

# Web VNC
RUN apt-get install -y --force-yes --no-install-recommends gcc python-dev nginx \
	python-numpy \
    && apt-get autoclean -y \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/apt/archives/*.deb

ADD system/web/web/requirements.txt /web-requirements.txt
RUN pip install setuptools wheel \
    && pip install -r /web-requirements.txt \
    && rm /web-requirements.txt

	
RUN apt-get install -y --force-yes --no-install-recommends \
	gcc g++ \
	&& apt-get autoclean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

RUN apt-get -y update && apt-get install -y --force-yes --no-install-recommends \
	iptables rsyslog fail2ban pwgen net-tools

# For gateone invalid ip check
RUN pip install netifaces

RUN apt-get autoclean \
	&& apt-get autoremove \
	&& rm -rf /var/lib/apt/lists/*

ADD system/base/ /
ADD system/web/ /

EXPOSE 6080 443

ENTRYPOINT ["./startup.sh"]
