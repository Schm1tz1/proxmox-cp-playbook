resource "proxmox_vm_qemu" "ksql" {
  count        = var.ksql-count
  name         = "cp-ksql-${count.index}"
  vmid         = "377${count.index}"
  desc         = "CP ksqlDB Node ${count.index}"
  clone        = var.proxmox_vm_template
  target_node  = "atlas"

  os_type      = "cloud-init"
  ipconfig0    = "ip=10.0.0.7${count.index}/24,gw=${var.network_gateway}"
  ssh_user     = "ubuntu"
  sshkeys      = var.ssh_key

  cores        = 1
  sockets      = 1
  memory       = 6000

  disk {
    size            = "8G"
    type            = "scsi"
    storage         = "local-zfs"
  }

}
