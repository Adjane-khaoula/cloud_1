cloud-1/
├── terraform/
│   ├── main.tf                  # 
│   ├── vm_config.tf
│   ├── vm_firewall_rules.tf
│   ├── variables.tf             # (optional) if you have/plan to add variables
│   ├── outputs.tf               # (optional) to define outputs
│   ├── terraform.tfstate
│   ├── terraform.tfstate.backup
│   ├── .terraform/
│   └── .terraform.lock.hcl
│
├── scripts/
│   ├── create_service_account.sh   # create service account for terraform that include assigning roles and generate and export key
│   ├── delete_service_account.sh   # delete service account, remove roles and unset key
│                   
│
├── env/
│   └── cloud-1-key.json            # Service account key
│
├── Makefile                        # Automate some commun command of terraform (init , plan , apply, destry)
└── README.md                       # Overview of your Terraform project


##main.tf

This is the main Terraform configuration file that sets up the Google Cloud provider. It:

    Specifies the required provider (google) and its version.

    Ensures Terraform version compatibility.

    Configures the default project, region, and zone for all Google Cloud resources in this deployment.

Terraform uses this file to know which provider to use and where to deploy the infrastructure.


##vm_config.tf

This file defines the configuration for a Virtual Machine (VM) instance on Google Cloud Platform (GCP). It includes:

    VM Name: tariq-cloud-1-vm

    Machine Type: e2-medium

    Operating System: Ubuntu 20.04 LTS

    Network: Connects to the default VPC and assigns an external IP.

    SSH Access: Allows access using the local SSH public key found at ~/.ssh/id_rsa.pub.

    Tags: Assigns network tags web and dev (useful for applying firewall rules).

Terraform uses this definition to create and manage the VM infrastructure automatically.

##vm_firewall_rules.tf

This file defines two firewall rules to allow HTTP and HTTPS traffic to the VM instance:

    Rule: allow-http

        Port: 80 (HTTP)

        Protocol: TCP

        Direction: Ingress (incoming traffic)

        Source Range: 0.0.0.0/0 (open to all IP addresses)

        Target Tags: web

    Rule: allow-https

        Port: 443 (HTTPS)

        Protocol: TCP

        Direction: Ingress

        Source Range: 0.0.0.0/0

        Target Tags: web

These rules are automatically applied to the VM instance during its creation by Terraform, based on its assigned network tag web.



##Terraform State & Lock Files

Terraform generates the following files and directories to manage and track infrastructure state:

    terraform.tfstate
    Stores the current state of the infrastructure. This file is essential for Terraform to know what resources exist and how to manage them.

    terraform.tfstate.backup
    A backup of the previous state file. Automatically created before each state-changing operation for recovery purposes.

    .terraform/
    A hidden directory that holds provider binaries and configuration data used internally by Terraform after initialization (terraform init).

    .terraform.lock.hcl
    A lock file that ensures consistent provider versions across environments. Helps prevent unexpected behavior due to provider version changes.

    ⚠️ Note: These files should not be edited manually. They are critical to how Terraform operates.
    You may also consider adding them to .gitignore (except the lock file, which is usually tracked)
    to avoid committing sensitive or environment-specific data.


##outputs.tf

The outputs.tf file is where you can define output variables in Terraform.
These outputs are values generated from the resources created, such as the VM's ID, IP address,
or other details that might be needed for other processes. For example,
you might want to use these values in your CI/CD pipelines, or for other automation tasks. 

##variables.tf

The variables.tf file is where you define variables that make your Terraform configurations dynamic.
Variables allow you to customize configurations and deployments without modifying the main code. 

##terraform.tfvars

The terraform.tfvars file is used to provide the actual values for the variables defined in variables.tf.
This is where you can specify values for variables like project ID, instance name, 
or any other dynamic values that are specific to your environment or deployment.



