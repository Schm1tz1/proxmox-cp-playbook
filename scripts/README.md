# Additional Tools and Bash Scripts

* **check_diskspace.sh** - check free disk space on al nodes over SSH
* **clean_pubkeys.sh** - clean local SSH pubkeys from nodes (needed after re-running terraform)
* **gen_ca.sh** - create CA
* **gen_certs.sh** - basic script to create certificates, based on [Confluent Platform Security Tools
](https://github.com/confluentinc/confluent-platform-security-tools)
* **install_jline.sh** - install jline2 on all nodes (for zookeeper shell)
* **pve_cp_cluster.sh** - (run on PVE host) info/start/shutdown script
* **pve_create_snapshot_cp.sh** - (run on PVE host) snapshot script for all nodes 
* **sasl_create_admin.sh** - create SASL-SCRAM admin account on ZK (important especially after activating SCRAM with resulting failures in ZK connections !)
* **setup_jumphost.sh** - Jumphost installation and packages

In case you don't have a DNS set up and want to use the host names locally to */etc/hosts* on the nodes, you can use **update_hosts.sh**.
To add the local CA to the trusted certificate store on all the nodes, simply run **extract_and_push_ca.sh**. 