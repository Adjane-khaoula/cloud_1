# #!/bin/bash

# # Path to the Terraform output file
# TF_OUTPUT_JSON="/home/khaoula/cloud_1/terraform/deploy_machine_on_gcp/env/ansible_env_vars.json"

# # Read IP and user from JSON using jq
# IP=$(jq -r '.vm_instance_ip.value' "$TF_OUTPUT_JSON")
# USER=$(jq -r '.vm_user.value' "$TF_OUTPUT_JSON")

# # Validate values
# if [[ -z "$IP" || "$IP" == "null" ]]; then
#   echo "❌ IP address not found in $TF_OUTPUT_JSON"
#   exit 1
# fi

# if [[ -z "$USER" || "$USER" == "null" ]]; then
#   echo "❌ Username not found in $TF_OUTPUT_JSON"
#   exit 1
# fi

# # Generate inventory.ini
# INVENTORY_PATH="/home/khaoula/cloud_1/ansible/inventory.ini"
# cat > "$INVENTORY_PATH" <<EOF
# [servers]
# $IP ansible_user=$USER ansible_ssh_private_key_file=~/.ssh/id_rsa
# EOF

# echo "✅ Inventory file generated at $INVENTORY_PATH"


#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Terraform outputs file path
OUTPUTS="/home/khaoula/cloud_1/terraform/deploy_machine_on_gcp/env/ansible_env_vars.json"

echo -e "${BLUE}Generating inventory.yaml from Terraform outputs...${NC}"

# Activate Python environment (if needed)
source ../../installation_script/ansible-env/bin/activate

# Read the JSON values from the Terraform outputs
vm_instance_ip=$(jq -r '.vm_instance_ip.value' $OUTPUTS)
vm_user=$(jq -r '.vm_user.value' $OUTPUTS)

# Create the inventory.yaml file with proper formatting
cat <<EOF > inventory.yaml
cloud:
  hosts:
    cloud1:
      ansible_host: $vm_instance_ip
      ansible_user: $vm_user
      ansible_ssh_private_key_file: "~/.ssh/id_rsa"
EOF

echo  "ExternalIP:  $vm_instance_ip"  > vm_external_ip.yaml
# Deactivate Python environment (if activated)
deactivate

echo -e "${GREEN}inventory.yaml generated successfully!${NC}"

