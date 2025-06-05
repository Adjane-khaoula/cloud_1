#!/bin/bash
#
# Install Terraform

read -sp "Enter sudo password: " Password
echo

echo "------------------- Update system ------------------------"
echo $Password | sudo -S apt update && sudo apt install -y unzip wget

echo "------------------- Download Terraform -------------------"
TERRAFORM_VERSION="1.6.6"  # You can change this to any version you like
wget https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "------------------- Unzip and Install ---------------------"
unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip
echo $Password | sudo -S mv terraform /usr/local/bin/
rm terraform_${TERRAFORM_VERSION}_linux_amd64.zip

echo "------------------- Verify Installation -------------------"
terraform -v

echo "✅ Terraform ${TERRAFORM_VERSION} installed successfully!"

