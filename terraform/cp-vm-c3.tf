resource "proxmox_vm_qemu" "c3" {
  count        = var.c3-count
  name         = "cp-c3-${count.index}"
  vmid         = "379${count.index}"
  desc         = "CP Control Center Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.9${count.index}/24,gw=${var.network_gateway}"
  ssh_user     = "ubuntu"
  sshkeys      = var.ssh_key

  cores        = 2
  sockets      = 1
  memory       = 9000

  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local-zfs"
  }

}
