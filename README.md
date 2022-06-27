# Proxmox Playbooks for CP installations

This provides a full working example to prepare a cloud-init image as a tempalte, then set up VMs in PVE with terraform and deploy Confluent Platform with cp-ansible on those VMs.

## Preparation
* In case you need a jumphost between the networks that also serves as master / ansible control node, install a small LXC or VM. A script that installs the tools you need can be found in [./scripts/setup_jumphost.sh](./scripts/setup_jumphost.sh) (created with Ubuntu 20.04)
* Create a SSH keypair you will use to connect to your VM nodes and use with ansible: `ssh-keygen`
* On your PVE host: Use the scripts in [./terraform/preparation/](./terraform/preparation/) to download a cloud-init image, modify it and create a VM template. Also have a look at [./terraform/README.md](./terraform/README.md) for an example !
* **IMPORTANT:** Make sure you have a correct *hosts.new* file as this will be used as a source for most of the scripts !  

## Terraform Configuration and VM deployment
* Create your variables in *terraform.tfvars* - use [terraform/terraform.tfvars.example](terraform/terraform.tfvars.example) as template/example
* the default IP range is 10.0.0.0/24 starting with 10.0.0.3x for ZK, 10.0.0.4x for Brokers and so on. You might need to adapt the IPs in cp-vm-\*.tf to your needs.
* Add your credentials for PVE - use [./terraform/credentials.auto.tfvars.example](./terraform/credentials.auto.tfvars.example) as template/example

In addition have a look at [./terraform/README.md](./terraform/README.md).

## Ansible Installation

Please refer to [./ansible/README.md](./ansible/README.md)

* For TLS / mTLS you might want to create a CA and certificates - have a look at **scripts/gen_ca.sh** and **scripts/gen_certs.sh** and the corresponding configurations *ca.cnf* and *template.cnf*
* If you run into issues connecting to ZK after a (partial) installation with SASL-SCRAM, check **scripts/sasl_create_admin.sh**
* Creation of ACLs for (non-admin) users can be done with a script like **scripts/set_ACLs.sh**. You will need to create the corresponding client properties.

## Cluster / Node Management
You can use the following scripts **scripts/pve_(...)**:
- **pve_remove_cloudinit.sh** - removes the cloudinit virtual cdrom drive 
- **pve_cp_cluster.sh** - scripts to start/stop the cluster (in correct order, lowest ID should be ZK, highest C3)
- **pve_create_snapshot_cp.sh**, **pve_delete_snapshot_cp.sh** and **pve_rollback_snapshot_cp.sh** Are used for snapshot management of all cluster nodes
   