#!/usr/bin/env bash

USER_NAME=admin
USER_PASS=admin_secret

ZOOKEEPER=10.0.0.30
BROKER=10.0.0.40

echo "Adding '$USER_NAME' with PW '$USER_PASS' ..."
ssh -l ubuntu ${BROKER} "sudo kafka-configs --zookeeper ${ZOOKEEPER}:2181 --alter --add-config 'SCRAM-SHA-256=[password=${USER_PASS}],SCRAM-SHA-512=[password=${USER_PASS}]' --entity-type users --entity-name ${USER_NAME}"
echo

echo "Checking in ZK configs ..."
ssh -l ubuntu ${BROKER} "sudo zookeeper-shell ${ZOOKEEPER}:2181 get /config/users/admin"
