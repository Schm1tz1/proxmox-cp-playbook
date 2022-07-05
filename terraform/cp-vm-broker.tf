resource "proxmox_vm_qemu" "broker" {
  count        = var.broker-count
  name         = "cp-broker-${count.index}"
  vmid         = "374${count.index}"
  desc         = "CP Broker Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.4${count.index}/24,gw=${var.network_gateway}"
  ssh_user     = "ubuntu"
  sshkeys      = var.ssh_key

  cores        = 2
  sockets      = 1
  memory       = 9000

  disk {
    size            = "16G"
    type            = "scsi"
    storage         = "local-zfs"
  }

}
