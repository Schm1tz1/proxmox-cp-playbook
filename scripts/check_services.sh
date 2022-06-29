#!/usr/bin/env bash

for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f3); do
    allPorts=(2181 2182 9092 8081 8082 8088 8083 9021)
    echo -n ""$i: ""

    for PORT in ${allPorts[@]}; do
        nc -w1 -vz $i $PORT 2>/dev/null
        if [ $? -eq 0 ]
        then
            echo -n "Ok"
            break
        fi
    done
    echo
done