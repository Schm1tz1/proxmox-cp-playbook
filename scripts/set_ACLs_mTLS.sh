#!/usr/bin/env bash

BROKER=cp-broker-0
CLIENT_CONFIG=/home/ubuntu/client-admin-mTLS.properties
PORT=9092
ZOOKEEPER=cp-zk-0
ZK_PORT=2182

ssh -l ubuntu ${BROKER} "sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --topic _confluent-command && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --topic _confluent-controlcenter --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --topic _confluent-monitoring && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --topic _confluent-metrics && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --group _confluent-controlcenter --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-c3-0.homelab.internal --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --topic _confluent-ksql-default__command_topic && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-ksql-0.homelab.internal --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --topic connect-cluster- --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --group connect-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-connect-0.homelab.internal --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-schema-0.homelab.internal --topic _schemas && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --add --allow-principal User:cp-schema-0.homelab.internal --group cp-schema-0.homelab.internal"

echo
echo "Listing ACLs..."
ssh -l ubuntu ${BROKER} "sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config ${CLIENT_CONFIG} --list"

echo
echo "Checking on Zookeeper..."
ssh -l ubuntu ${BROKER} "sudo zookeeper-shell ${ZOOKEEPER}:${ZK_PORT} -zk-tls-config-file /etc/kafka/zookeeper-tls-client.properties ls /kafka-acl/Cluster"