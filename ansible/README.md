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
