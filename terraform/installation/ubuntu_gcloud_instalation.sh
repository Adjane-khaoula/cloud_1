#!/bin/bash

# Read sudo password
read -sp "Enter sudo password: " Password
echo

# Update and install required dependencies
echo "----------------- # Update and install required dependencies               -------------------"
echo $Password | sudo -S apt-get update

# Install required dependencies
echo "----------------- # Install required dependencies                          --------------------"
echo $Password | sudo -S apt-get install -y apt-transport-https ca-certificates gnupg curl

# Import the Google Cloud public key

echo "----------------- # Import the Google Cloud public key                      --------------------"
echo $Password | sudo -S curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg

# Add the gcloud CLI distribution URI as a package source

echo "----------------- # Add the gcloud CLI distribution URI as a package source --------------------"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

# Update
echo "----------------- # Update                                                  --------------------"
echo $Password | sudo -S apt-get update
# Install the gcloud CLI
echo "----------------- # Install the gcloud CLI                                  --------------------"
echo $Password | sudo -S apt-get install -y google-cloud-cli

# Initialize gcloud CLI
#gcloud init

