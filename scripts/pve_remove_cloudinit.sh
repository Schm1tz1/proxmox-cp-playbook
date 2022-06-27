#!/usr/bin/env bash

VM_NAME_PATTERN='cp-(.*)-[[:digit:]+]'
VMLIST=$(qm list | grep -E $VM_NAME_PATTERN | sed 's/^ *//g' | cut --fields=1 --delimiter=' ')

echo Removing virtual cloud init cdrom for VMs $VMLIST ...
read -p 'Press any key to continue...'

 for i in $VMLIST; do
     qm set $i -ide2 media=cdrom,file=none
 done

