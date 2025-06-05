output "vm_instance_name" {
  description = "The name of the VM instance"
  value       = google_compute_instance.vm_instance.name
}

output "vm_instance_ip" {
  description = "The external IP address of the VM"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}

output "vm_instance_id" {
  description = "The ID of the created VM instance"
  value       = google_compute_instance.vm_instance.id
}

output "vm_user" {
  description = "The SSH user for the VM"
  value       = var.ssh_user
}
