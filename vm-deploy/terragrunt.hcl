terraform {
  #source = "git::https://github.com/tools.git//terraform?ref=${get_env("modules_tag")}"
  source = "../terraform"
}

 include "root" {
  path = find_in_parent_folders()
}

inputs = {
  onprem_vm = local.onprem_vm
}

locals {
  onprem_vm = {
    "bastion" = {
      vm_id   = 230
      name    = "zed-bastion"
      cores   = 2
      memory  = 8192
      sockets = 4
      disks   = [
        { slot = "virtio0", size = "50G", type = "disk", storage = "pve-sda" },
        { slot = "virtio1", size = "50G", type = "disk", storage = "pve-sda" }
      ]
      network = [
        { model = "virtio", bridge = "vmbr1", tag = 124, link_down = false, firewall = true },
        { model = "virtio", bridge = "vmbr1", tag = 100, link_down = false, firewall = true }
      ]
    },
    "main-01" = {
      vm_id   = 230
      name    = "zed-main-01"
      cores   = 2
      memory  = 8192
      sockets = 4
      disks   = [
        { slot = "virtio0", size = "50G", type = "disk", storage = "pve-sda" },
        { slot = "virtio1", size = "50G", type = "disk", storage = "pve-sda" }
      ]
      network = [
        { model = "virtio", bridge = "vmbr1", tag = 124, link_down = false, firewall = true },
        { model = "virtio", bridge = "vmbr1", tag = 100, link_down = false, firewall = true }
      ]
    }    
  }
}

