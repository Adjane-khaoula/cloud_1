#!/bin/bash

# Read sudo password
read -sp "Enter sudo password: " Password
echo

# Update package list
echo $Password | sudo -S apt-get update

# Uninstall the gcloud CLI and remove dependencies
echo $Password | sudo -S apt-get remove --purge -y google-cloud-cli

# Remove the package source list for Google Cloud SDK
echo $Password | sudo -S rm -f /etc/apt/sources.list.d/google-cloud-sdk.list

# Remove the Google Cloud public key
echo $Password | sudo -S rm -f /usr/share/keyrings/cloud.google.gpg

# Clean up any unused dependencies
echo $Password | sudo -S apt-get autoremove -y
echo $Password | sudo -S apt-get clean

# Optionally, you can remove any additional installed components (uncomment if needed)
# echo $Password | sudo -S apt-get remove --purge -y google-cloud-cli-app-engine-java

echo "Google Cloud CLI has been successfully uninstalled."

