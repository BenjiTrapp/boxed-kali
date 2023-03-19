FROM kalilinux/kali-rolling:latest

LABEL org.opencontainers.image.author="benjitrapp.github.io"

ARG KALI_METAPACKAGE=core
ARG KALI_DESKTOP=xfce

ENV VNCEXPOSE 1
ENV VNCPORT 5900
ENV VNCPWD password
ENV VNCDISPLAY 1920x1080
ENV VNCDEPTH 16
ENV USER root

ENV NOVNCPORT 8080
ENV DEBIAN_FRONTEND noninteractive

ENV GOROOT=/usr/lib/go
ENV GO111MODULE=on
ENV GOPATH=$HOME/go
ENV PATH=$GOPATH/bin:$GOROOT/bin:$PATH
ENV AWS_DEFAULT_REGION=eu-central-1


RUN apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get clean \
    && apt-get install -y --no-install-recommends software-properties-common curl wget vim nano build-essential autoconf automake libtool 

# https://www.kali.org/tools/kali-meta/#kali-tools-forensics
RUN apt-get install -y --no-install-recommends --allow-unauthenticated kali-linux-${KALI_METAPACKAGE} \
                                                                       kali-desktop-${KALI_DESKTOP} \
                                                                       kali-tools-top10 \
                                                                       kali-tools-forensics \
                                                                       kali-tools-web \
                                                                       kali-tools-windows-resources \
                                                                       binutils \
                                                                       burpsuite \
                                                                       libproxychains4 \
                                                                       proxychains4 \
                                                                       exploitdb \
                                                                       bloodhound \
                                                                       kerberoast \
                                                                       fail2ban \
                                                                       whois \
                                                                       ghidra \
                                                                       sslscan \
                                                                       traceroute \
                                                                       whois \
                                                                       powershell \
                                                                       git \
                                                                       jq \
                                                                       gobuster \
                                                                       python3-full \
                                                                       python3-pip \ 
                                                                       python3-dev build-essential \ 
                                                                       golang-go \ 
                                                                       tightvncserver \
                                                                       dbus \
                                                                       dbus-x11 \
                                                                       novnc \
                                                                       net-tools \
                                                                       xfonts-base \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

RUN pip3 install --break-system-package --no-cache-dir --upgrade pip  && \
    pip3 install --break-system-package --no-cache-dir awscli boto3 pacu trufflehog endgame notebook

COPY containerfiles/entrypoint.sh /entrypoint.sh
COPY containerfiles/bashrc.sh /bashrc.sh
RUN chmod +x /entrypoint.sh

RUN git clone https://github.com/duo-labs/cloudmapper.git /opt/cloudmapper

ENTRYPOINT [ "/entrypoint.sh" ]
