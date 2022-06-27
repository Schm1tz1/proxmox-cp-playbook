resource "proxmox_vm_qemu" "connect" {
  count        = var.connect-count
  name         = "cp-connect-${count.index}"
  vmid         = "378${count.index}"
  desc         = "CP Connect Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.8${count.index}/24,gw=${var.network_gateway}"
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
