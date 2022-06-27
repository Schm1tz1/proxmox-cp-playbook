#!/usr/bin/env bash

USER_NAME=admin
USER_PASS=admin_secret

BROKER=cp-broker-0
PORT=9092
ZOOKEEPER=cp-zk-0
ZK_PORT=2182

ssh -l ubuntu ${BROKER} "sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --topic _confluent-command && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --topic _confluent-controlcenter --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --topic _confluent-monitoring && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --topic _confluent-metrics && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --group _confluent-controlcenter --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:control-center --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --topic _confluent-ksql-default__command_topic && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:ksqldb --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --topic connect-cluster- --resource-pattern-type PREFIXED && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --group connect-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --operation Describe --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --operation DescribeConfigs --cluster kafka-cluster && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --operation Describe --group '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:kafka-connect --topic '*' && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:schema-registry --topic _schemas && \
 sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --add --allow-principal User:schema-registry --group schema-registry"

echo
echo "Listing ACLs..."
ssh -l ubuntu ${BROKER} "sudo kafka-acls --bootstrap-server ${BROKER}:${PORT} --command-config /home/ubuntu/client-SASL.properties --list"

echo
echo "Checking on Zookeeper..."
ssh -l ubuntu ${BROKER} "sudo zookeeper-shell ${ZOOKEEPER}:${ZK_PORT} -zk-tls-config-file /etc/kafka/zookeeper-tls-client.properties ls /kafka-acl/Cluster"
