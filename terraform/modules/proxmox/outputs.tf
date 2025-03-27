/*
output "vm_id" {
  description = "The VM Id."
  value       = proxmox_vm_qemu.test_server[*].vmid
}

output "vm_name" {
  description = "The VM name."
  value       = proxmox_vm_qemu.test_server[*].name
}

output "clone" {
  description = "Template name that this VM was cloned from."
  value       = proxmox_vm_qemu.test_server[*].clone
}

output "ip" {
  value = proxmox_vm_qemu.test_server[*].target_node
}
*/