resource "proxmox_vm_qemu" "zookeeper" {
  count        = var.zk-count
  name         = "cp-zk-${count.index}"
  vmid         = "373${count.index}"
  desc         = "CP Zookeeper Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.3${count.index}/24,gw=${var.network_gateway}"
  ssh_user     = "ubuntu"
  sshkeys      = var.ssh_key

  cores        = 1
  sockets      = 1
  memory       = 4000

  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local-zfs"
  }

}
