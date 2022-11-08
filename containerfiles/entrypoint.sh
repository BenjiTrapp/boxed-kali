#!/bin/bash

function set_dns_nameserver() {
  DNS_NAMESERVER="${DNS_NAMESERVER:-8.8.8.8}"
  echo "$DNS_NAMESERVER" >> /etc/resolv.conf
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
  if [ "$VNCEXPOSE" = 1 ]; then
    # Expose VNC
    vncserver :0 -rfbport ${VNCPORT} -geometry ${VNCDISPLAY} -depth ${VNCDEPTH} \
      > /var/log/vncserver.log 2>&1
  else
    # Localhost only
    vncserver :0 -rfbport ${VNCPORT} -geometry ${VNCDISPLAY} -depth ${VNCDEPTH} -localhost \
      > /var/log/vncserver.log 2>&1
  fi

  /usr/share/novnc/utils/launch.sh --listen ${NOVNCPORT} --vnc localhost:${VNCPORT} \
    > /var/log/novnc.log 2>&1 &

  echo "Launch your web browser and open http://localhost:9020/vnc.html"
}

function main() {
  set_dns_nameserver
  start_postgresql
  set_vnc_creds
  start_vnc_server
}

# Run Forrest run!
main

# Required to keep the container alive in a more graceful way
/bin/bash
