#!/usr/bin/env bash

for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f1); do
    echo -n ""$i: ""
    ssh $i -l ubuntu "df -h | grep -E '/sda1[ /t]' "
done
