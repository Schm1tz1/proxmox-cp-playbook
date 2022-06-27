#!/usr/bin/env bash

for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f1); do
    echo "Installing jline on ${i} ..."
    ssh ubuntu@${i} "curl -O https://repo1.maven.org/maven2/jline/jline/2.14.6/jline-2.14.6.jar && sudo cp -rv jline-2.14.6.jar /usr/share/java/kafka/ && rm -vf jline-2.14.6.jar"
    echo
done
