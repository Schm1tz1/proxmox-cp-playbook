# Ansible Playbooks for PVE-Deployment

## Checkout from Ansible Galaxy
Check out the latest CP via `ansible-galaxy collection install git+https://github.com/confluentinc/cp-ansible.git`.

## Configuration and Test
* minimal ansible config for CP:
```
[defaults]
hash_behaviour=merge
#host_key_checking = False
#enable_task_debugger = True
```
* Ping test: `ansible -i ./hosts.yml all -m ping`

## Installation
* Full installation: `ansible-playbook -i ./hosts.yml confluent.platform.all`
* Partial installation/update: `ansible-playbook -i ./hosts.yml --skip-tags package,common confluent.platform.all`

## Description of inventory files
* **hosts-simple.yml** - simple setup without security
* **hosts-mTLS.yml** - mTLS for encryption and authentication
* **hosts-mTLS-ACLs.yml** - mTLS with ACLs based on CN
* **hosts-SASL-SCRAM.yml** - TLS with SASL-SCRAM and ACLs

**Note on ACLs:** After activating ACLs, all of your connections with non-super.user-principal will fail! You need to add the ACLs from the broker with a super.user and re-run. 