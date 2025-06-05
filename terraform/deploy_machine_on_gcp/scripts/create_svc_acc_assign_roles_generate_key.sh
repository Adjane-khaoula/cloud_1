#!/bin/bash

#The perpose of this script is automatically create an Service Account and assign roles for terraform.
#The script also generate and download the key and then export it

#Make sure you have run gcloud auth login and selected the correct project 
echo "Make sure you have run gcloud auth login and selected the correct project\n\n"

#just adding some dummy seceruty
read -sp "Enter sudo password: " Password
echo
read -p "Enter your project id: " PROJECT_ID
echo

# Exit on error
set -e

# Your project ID
#PROJECT_ID="sapient-tangent-456419-j5"
# Service account name and ID
SERVICE_ACCOUNT_NAME="cloud-1-service-account"
SERVICE_ACCOUNT_ID="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# 1. Create the service account (skip if already created)
echo "Creating service account '${SERVICE_ACCOUNT_NAME}' in project '${PROJECT_ID}'..."
gcloud iam service-accounts create "${SERVICE_ACCOUNT_NAME}" \
  --description="Service account for Terraform automation" \
  --display-name="Cloud-1-service-account" \
  --project="${PROJECT_ID}" || echo "Service account may already exist, skipping."


# Wait for service account to exist
until gcloud iam service-accounts describe "$SERVICE_ACCOUNT_ID" --project "$PROJECT_ID" &> /dev/null; do
  echo "Waiting for service account to be ready..."
  sleep 2
done

# 2. Assign IAM roles
echo "Assigning roles to service account..."

ROLES=(
  "roles/compute.admin"
  "roles/compute.viewer"
  "roles/compute.networkAdmin"
  "roles/iam.serviceAccountUser"
)

for ROLE in "${ROLES[@]}"; do
  echo "Assigning ${ROLE}..."
  gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
    --member="serviceAccount:${SERVICE_ACCOUNT_ID}" \
    --role="${ROLE}"
done

echo "✅ Service account setup complete!"

# 3. Generate and download service account key
#
# Set key file path relative to this script location
#KEY_FILE="./env/cloud-1-key.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEY_FILE="$SCRIPT_DIR/../env/cloud-1-key.json"

if [[ ! -f "$KEY_FILE" ]]; then
  echo "Generating service account key..."
  gcloud iam service-accounts keys create "$KEY_FILE" \
    --iam-account="$SERVICE_ACCOUNT_ID" \
    --project="$PROJECT_ID"
else
  echo "Key already exists at $KEY_FILE, skipping key generation."
fi

# 4. Export credentials for Terraform
echo "Exporting GOOGLE_APPLICATION_CREDENTIALS..."
export GOOGLE_APPLICATION_CREDENTIALS="$KEY_FILE"


echo "✅ Key generated, downloaded and exported!."
echo "Make sure is this env variable is exported"
echo 'GOOGLE_APPLICATION_CREDENTIALS=/path-to-cloud-1-foulder/cloud-1/terraform/deploy_machine_on_gcp/env/cloud-1-key.json'
'"
