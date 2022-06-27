#!/usr/bin/env bash

TRUSTSTORE=/root/workspace/cp-proxmox-playbook/certs/truststore.jks
STOREPASS=changeme

# extracts the ROOT CA from truststore
keytool -keystore $TRUSTSTORE -export -alias caroot -storepass $STOREPASS -file root-ca.cer

# convert to PEM
openssl x509 -inform der -in root-ca.cer -out root-ca.crt

# trust locally
sudo cp root-ca.crt /usr/local/share/ca-certificates/
sudo update-ca-certificates

# push to nodes and add as trusted authority
for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f1); do
    echo "Trusting certificate on $i ..."
    scp root-ca.crt ubuntu@$i:
    ssh ubuntu@$i "sudo cp root-ca.crt /usr/local/share/ca-certificates/root-ca.crt -v && sudo update-ca-certificates --fresh"
    echo
done
