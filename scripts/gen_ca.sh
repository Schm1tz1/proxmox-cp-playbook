#!/usr/bin/env bash

CA_DIR=.

# Generate CA certificates and concatenate to PEM
openssl req -new -nodes -x509 -days 3650 -newkey rsa:2048 -keyout ${CA_DIR}/ca.key -out ${CA_DIR}/ca.crt -config ca.cnf
cat ${CA_DIR}/ca.crt ${CA_DIR}/ca.key > ${CA_DIR}/ca.pem

# show certificate
openssl x509 -in ${CA_DIR}/ca.crt -text | less

