#!/usr/bin/env bash

prepare_hosts() {
  HOST=$1
  ssh ubuntu@${HOST} "grep '# BEGIN CP' /etc/hosts >/dev/null || echo '# BEGIN CP
# END CP' | sudo tee -a /etc/hosts" >/dev/null && echo "  * Checked/added CP markers to /etc/hosts."
}

update_hosts() {
  HOST=$1
  scp -pr hosts.new ubuntu@${HOST}: >/dev/null
  ssh ubuntu@${HOST} "sudo sed -i -e '/^# BEGIN CP/!b;:a;N;/^# END CP/M!ba;r hosts.new' -e 'd' /etc/hosts" >/dev/null && echo "  * Updated /etc/hosts."
}

echo "Updating local /etc/hosts ..."
sudo sed -i -e '/^# BEGIN CP/!b;:a;N;/^# END CP/M!ba;r hosts.new' -e 'd' /etc/hosts >/dev/null && echo "  ok"

IFS=$'\n'
set -f
for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f1); do
  echo "Updating /etc/hosts on $i ..."
  prepare_hosts $i
  update_hosts $i
  echo
done

