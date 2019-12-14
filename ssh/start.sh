#!/usr/bin/env bash

if [[ -z "$SCP_PASSWORD" ]]; then
  export SCP_PASSWORD=balenaserver
fi

mkdir /var/run/sshd
echo "root:$SCP_PASSWORD" | chpasswd
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

export NOTVISIBLE="in users profile"
echo "export VISIBLE=now" >> /etc/profile

exec /usr/sbin/sshd -D
