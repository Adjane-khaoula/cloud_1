# #Define Linux ubuntu machine for GCP


# resource "google_compute_instance" "vm_instance" {
#   name         = var.instance_name
#   machine_type = var.machine_type
#   zone         = var.zone

#   boot_disk {
#     initialize_params {
#       image = var.os_image
#     }
#   }

#   network_interface {
#     network       = "default"
#     access_config {}
#   }

#   provisioner "local-exec" {
#   command = <<EOT
#     echo "[servers]" > inventory.ini
#     echo "${google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip} ansible_user=${var.ssh_user} ansible_ssh_private_key_file=${var.ssh_key} ansible_become=yes" >> inventory.ini
#     ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i inventory.ini site.yaml
#   EOT
# }

#   metadata = {
#     ssh-keys = "${var.ssh_user}:${file(abspath(var.ssh_key))}"
#     startup-script = <<EOT
#         #!/bin/bash
#         set -e

#         # Set the user password
#         echo "tariq:${var.ssh_password}" | chpasswd

#         # Remove tariq from google-sudoers if present
#         deluser tariq google-sudoers || true

#         # Create custom sudoers file that requires password
#         echo "tariq ALL=(ALL) ALL" > /etc/sudoers.d/tariq-requires-password
#         chmod 440 /etc/sudoers.d/tariq-requires-password
      
#       EOT
#   }

#   tags = var.tags
# }

#Define Linux ubuntu machine for GCP


resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.os_image
    }
  }

  network_interface {
    network       = "default"
    access_config {}
  }

  metadata = {
    ssh-keys = "${var.ssh_user}:${file(abspath(var.ssh_key))}"
    startup-script = <<EOT
        #!/bin/bash
        set -e

        # Set the user password
        echo "tariq:${var.ssh_password}" | chpasswd

        # Remove tariq from google-sudoers if present
        deluser tariq google-sudoers || true

        # Create custom sudoers file that requires password
        echo "tariq ALL=(ALL) ALL" > /etc/sudoers.d/tariq-requires-password
        chmod 440 /etc/sudoers.d/tariq-requires-password
      
      EOT
  }

  tags = var.tags
}
