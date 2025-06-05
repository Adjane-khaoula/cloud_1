variable "project_id" {
  description = "The GCP project ID"
  type        = string
}

variable "region" {
  description = "The GCP region"
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone"
  default     = "us-central1-a"
}

variable "instance_name" {
  description = "Name of the VM instance"
  default     = "tariq-cloud-1-vm"
}

variable "machine_type" {
  description = "Machine type for the instance"
  default     = "e2-medium"
}

variable "os_image" {
  description = "OS used for VM"
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "tags" {
  description = "Network tags for the VM"
  type        = list(string)
  default     = ["web", "dev"]
}

variable "ssh_user" {
  description = "SSH user"
  default     = "tariq"
}


# variable "ssh_key" {
#   description = "SSH public key file path"
#   default     = "/home/tariq/.ssh/id_rsa.pub"
# }

variable "ssh_key" {
  description = "SSH public key file path"
  default     = "/home/khaoula/.ssh/id_rsa.pub"
}

variable "ssh_password" {
  description = "Sudo password"
  type        = string
}

