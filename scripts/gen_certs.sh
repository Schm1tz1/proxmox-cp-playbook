#!/usr/bin/env bash

GENERALPWD=changeme
DOMAIN=homelab.internal
CERT_DIR=../certs
DAYS=389

create_cert() {
    NAME=${1}
    FULLNAME=${2}
    IPADDR=${3}
    PWD=${4}

    # copy and adapt template
    cat template.cnf | sed "s/#FQDN#/${FULLNAME}/g" | sed "s/#SHORT#/${NAME}/g" | sed "s/#IPADDR#/${IPADDR}/g" >${CERT_DIR}/${NAME}.cnf

    # Generate server/client certificates
    openssl req -new -newkey rsa:2048 -keyout ${CERT_DIR}/$NAME.key -out ${CERT_DIR}/$NAME.csr -config ${CERT_DIR}/$NAME.cnf -nodes
    openssl x509 -req -days ${DAYS} -in ${CERT_DIR}/$NAME.csr -CA ${CERT_DIR}/ca.crt -CAkey ${CERT_DIR}/ca.key -CAcreateserial -out ${CERT_DIR}/$NAME.crt -extfile ${CERT_DIR}/$NAME.cnf -extensions v3_req
    openssl pkcs12 -export -in ${CERT_DIR}/$NAME.crt -inkey ${CERT_DIR}/$NAME.key -chain -CAfile ${CERT_DIR}/ca.pem -name $FULLNAME -out ${CERT_DIR}/$NAME.p12 -password pass:${PWD}

    # export key as PEM e.g. for use with kafkacat
    openssl pkcs12 -in ${CERT_DIR}/$NAME.p12 -out ${CERT_DIR}/$NAME.pem -passin pass:${PWD} -passout pass:${PWD}
}

keystore_import() {
    NAME=${1}
    PWD=${2}

    keytool -importkeystore -deststorepass ${PWD} -destkeystore ${CERT_DIR}/${NAME}.keystore.jks \
        -srckeystore ${CERT_DIR}/${NAME}.p12 \
        -deststoretype PKCS12  \
        -srcstoretype PKCS12 \
        -noprompt \
        -srcstorepass ${PWD}
}

# Creating TLS CA, Certificates and keystore / truststore
rm -rf ${CERT_DIR}
mkdir -p ${CERT_DIR}

# Copy previously generated CA
cp ca.* ${CERT_DIR}

# Create Truststore
keytool -keystore ${CERT_DIR}/truststore.jks -alias CARoot -import -file ${CERT_DIR}/ca.crt -storepass ${GENERALPWD}  -noprompt -storetype PKCS12

# Create Server Keys
IFS=$'\n'
set -f
for i in $(cat < hosts.new | grep -v '#' | cut -d ' ' -f3); do
    SHORTNAME=${i}
    LONGNAME=$(cat < hosts.new | grep -v '#' | grep ${SHORTNAME} | cut -d ' ' -f2)
    IPADDR=$(cat < hosts.new | grep -v '#' | grep ${SHORTNAME} | cut -d ' ' -f1)

create_cert "${SHORTNAME}" "${LONGNAME}" "${IPADDR}" "${GENERALPWD}"
    keystore_import "${SHORTNAME}" "${GENERALPWD}"
done

# Create Client Keys
create_cert "client" "client.${DOMAIN}" "${IPADDR}" "${GENERALPWD}"
keystore_import "client" "${GENERALPWD}"
