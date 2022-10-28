FROM kalilinux/kali-rolling:latest

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

RUN apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get clean \
    && apt-get install -y --no-install-recommends software-properties-common curl wget vim nano

# https://www.kali.org/tools/kali-meta/#kali-tools-forensics
RUN apt-get install -y --no-install-recommends --allow-unauthenticated kali-linux-${KALI_METAPACKAGE} \
                                                                       kali-tools-top10 \
                                                                       kali-tools-forensics \
                                                                       kali-tools-windows-resources \
                                                                       binutils \
                                                                       ghidra \
                                                                       git \
                                                                       gobuster \
                                                                       python3-pip python3-dev build-essential \ 
                                                                       kali-desktop-${KALI_DESKTOP} \
                                                                       tightvncserver \
                                                                       dbus  \
                                                                       dbus-x11  \
                                                                       novnc  \
                                                                       net-tools \
                                                                       xfonts-base \
    && apt-get -y autoclean \
    && apt-get -y autoremove \
    && rm -rf /var/lib/apt/lists/*

COPY containerfiles/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]
