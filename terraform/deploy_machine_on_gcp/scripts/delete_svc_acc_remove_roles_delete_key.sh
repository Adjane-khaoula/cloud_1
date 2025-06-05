#!/bin/bash

# The purpose of this script is to delete a previously created service account,
# remove its IAM bindings, and delete the associated key.

# Confirm user intention
read -p "Are you sure you want to delete the service account and its bindings? (yes/no): " confirm
if [[ "$confirm" != "yes" ]]; then
  echo "Aborted."
  exit 1
fi

# Read project ID
read -p "Enter your project ID: " PROJECT_ID

# Variables
SERVICE_ACCOUNT_NAME="cloud-1-service-account"
SERVICE_ACCOUNT_ID="${SERVICE_ACCOUNT_NAME}@${PROJECT_ID}.iam.gserviceaccount.com"

# Set key file path relative to this script location
#KEY_FILE="./env/cloud-1-key.json"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
KEY_FILE="$SCRIPT_DIR/../env/cloud-1-key.json"

# Roles to remove
ROLES=(
  "roles/compute.admin"
  "roles/compute.viewer"
  "roles/compute.networkAdmin"
  "roles/iam.serviceAccountUser"
)

# Remove IAM bindings
echo "Removing IAM roles from service account..."
for ROLE in "${ROLES[@]}"; do
  echo "Removing ${ROLE}..."
  gcloud projects remove-iam-policy-binding "${PROJECT_ID}" \
    --member="serviceAccount:${SERVICE_ACCOUNT_ID}" \
    --role="${ROLE}" \
    --quiet || echo "Failed to remove ${ROLE}, might not have been set."
done

# Delete the service account
echo "Deleting service account ${SERVICE_ACCOUNT_ID}..."
gcloud iam service-accounts delete "${SERVICE_ACCOUNT_ID}" \
  --project="${PROJECT_ID}" \
  --quiet || echo "Service account not found or already deleted."

# Delete the local key file
if [[ -f "$KEY_FILE" ]]; then
  echo "Deleting key file $KEY_FILE..."
  rm -f "$KEY_FILE"
else
  echo "Key file not found, skipping."
fi

# Unset credentials env variable
unset GOOGLE_APPLICATION_CREDENTIALS

echo "✅ Service account deleted and cleanup complete!"

