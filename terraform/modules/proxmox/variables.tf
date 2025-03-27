
variable "bastion_host" {

  default = "pve08"
}

variable "env_name" {

  default = "zed"
}

variable "vlan" {

  default = "124"
}


variable "template_name" {

  default = "ubuntu-2204-cloudinit-template"
}

variable "ssh_key" {

}

variable "onprem_vm" {
  type = map(object({
    vm_id   = number
    name    = string
    cores   = number
    memory  = number
    sockets = number
    disks   = list(object({ slot: string, size: string, type: string, storage: string }))
    network = list(object({ model: string, bridge: string, tag: number, link_down: bool, firewall: bool }))
  }))

  default = {
    "bastion" = {
      vm_id   = 230
      name    = "zed-bastion"
      cores   = 2
      memory  = 8192
      sockets = 4
      disks = [
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
