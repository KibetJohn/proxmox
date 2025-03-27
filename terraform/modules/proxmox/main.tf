resource "proxmox_vm_qemu" "qemu_vm" {
  for_each    = var.onprem_vm 
  vmid        = each.value.vm_id
  name        = each.value.name
  clone       = "ubuntu-2204-cloudinit-template"
  target_node = "pve03"
  agent       = 1
  os_type     = "cloud-init"
  cores       = each.value.cores
  sockets     = each.value.sockets
  cpu         = "host"
  memory      = each.value.memory
  scsihw      = "virtio-scsi-pci"
  bootdisk    = "virtio0"
  ipconfig0   = "ip=dhcp"
  ciuser      = "ubuntu"
  cipassword  = "Password!"
  sshkeys     = <<EOF
  ${var.ssh_key}
  EOF

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  serial {
    id = 0
    type = "socket" 
  }

  dynamic "network" {
    for_each = each.value.network
    content {
      model     = "each.value.model"
      bridge    = "each.value.bridge"
      tag       = each.value.tag
      link_down = each.value.link_down
      firewall  = each.value.firewall
    }
  }

  dynamic "disk" {
    for_each = each.value.disks
    content {
      slot    = "each.value.slot"
      size    = "each.value.size"
      type    = "each.value.type"
      storage = "each.value.storage"
    }
  }
}
