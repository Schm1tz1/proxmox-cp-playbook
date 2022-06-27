#!/usr/bin/env bash

 if [ "$#" -ne 1 ]; then
     echo "Please give the snapshot name as parameter!"
     exit 1
 fi

 VM_NAME_PATTERN='cp-(.*)-[[:digit:]+]'
 SNAPNAME="$1"
 VMLIST=$(qm list | grep -E $VM_NAME_PATTERN | sed 's/^ *//g' | cut --fields=1 --delimiter=' ')

 echo Creating snapshot \"$1\" for VMs $VMLIST ...
 read -p 'Press any key to continue...'


 for i in $VMLIST; do
     echo "Creating snapshot for VM $i ..."
     qm snapshot $i $SNAPNAME
 done
 