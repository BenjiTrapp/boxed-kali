#!/bin/bash

readonly SPLASH="
▄▄▄▄·       ▐▄• ▄ ▄▄▄ .·▄▄▄▄      ▄ •▄  ▄▄▄· ▄▄▌  ▪
▐█ ▀█▪▪      █▌█▌▪▀▄.▀·██▪ ██     █▌▄▌▪▐█ ▀█ ██•  ██
▐█▀▀█▄ ▄█▀▄  ·██· ▐▀▀▪▄▐█· ▐█▌    ▐▀▀▄·▄█▀▀█ ██▪  ▐█·
██▄▪▐█▐█▌.▐▌▪▐█·█▌▐█▄▄▌██. ██     ▐█.█▌▐█ ▪▐▌▐█▌▐▌▐█▌
·▀▀▀▀  ▀█▄▀▪•▀▀ ▀▀ ▀▀▀ ▀▀▀▀▀•     ·▀  ▀ ▀  ▀ .▀▀▀ ▀▀▀
"

function set_dns_nameserver() {
  DNS_NAMESERVER="${DNS_NAMESERVER:-8.8.8.8}"
  echo "nameserver $DNS_NAMESERVER" >> /etc/resolv.conf
}

function start_postgresql() {
  service postgresql start
  msfdb init > /dev/null 2>&1 &
}

function set_vnc_creds() {
  mkdir -p /root/.vnc/
  echo "$VNCPWD" | vncpasswd -f > /root/.vnc/passwd
  chmod 600 /root/.vnc/passwd
}

function start_vnc_server() {
  x11vnc -display :0 -autoport -localhost -nopw -bg -xkb -ncache -ncache_cr -quiet -forever

  /usr/share/novnc/utils/novnc_proxy --listen 8080 --vnc localhost:5900

  echo "Launch your web browser and open http://localhost:9020/vnc.html"
}

function main() {
  echo "$SPLASH"
  source /bashrc.sh
  set_dns_nameserver
  start_postgresql
  set_vnc_creds
  start_vnc_server
}

# Run Forrest run!
main

# Required to keep the container alive in a more graceful way
/bin/bash
