#!/usr/bin/env bash

for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f1); do
    ssh-keygen -f "/root/.ssh/known_hosts" -R "${i}"
done
