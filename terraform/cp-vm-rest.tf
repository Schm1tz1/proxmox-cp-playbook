resource "proxmox_vm_qemu" "rest" {
  count        = var.rest-count
  name         = "cp-rest-${count.index}"
  vmid         = "376${count.index}"
  desc         = "CP REST Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.6${count.index}/24,gw=${var.network_gateway}"
  ssh_user     = "ubuntu"
  sshkeys      = var.ssh_key

  cores        = 1
  sockets      = 1
  memory       = 5000

  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local-zfs"
  }

}
