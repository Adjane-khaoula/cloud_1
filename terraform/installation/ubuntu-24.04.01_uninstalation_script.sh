#!/bin/bash
#
# Uninstall Terraform

read -sp "Enter sudo password: " Password
echo

echo "------------------- Removing Terraform binary ------------------------"

# Remove Terraform binary
if [ -f "/usr/local/bin/terraform" ]; then
  echo $Password | sudo -S rm /usr/local/bin/terraform
  echo "✅ Removed /usr/local/bin/terraform"
else
  echo "⚠️ Terraform binary not found in /usr/local/bin"
fi

# Optional: Clean up zip file if still present
TERRAFORM_ZIP=$(ls terraform_*_linux_amd64.zip 2>/dev/null)
if [ -n "$TERRAFORM_ZIP" ]; then
  rm "$TERRAFORM_ZIP"
  echo "🧹 Removed leftover ZIP: $TERRAFORM_ZIP"
fi

echo "------------------- Done. Terraform uninstalled. ---------------------"

