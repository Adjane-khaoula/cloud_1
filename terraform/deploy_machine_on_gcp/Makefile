#Terraform Basic command Makefile

all:
	# Initialize Terraform (only once)
	terraform init
plan:
	# Preview what will be created
	terraform plan
apply:
	# Create the infra (like VMs, firewalls, etc.)
	terraform apply
	#create env folder
	mkdir -p ./env
	#Save outputs vars on ./env/ansible_env_vars.json file
	terraform output -json > ./env/ansible_env_vars.json
	# Show all Terraform outputs (VM IP, ID, name) type "make show-outputs"
destroy:
	# Destroy everything later to save cloud costs
	terraform destroy
	rm -rf terraform.tfstate terraform.tfstate.backup
clean:
	#Clean init command result
	rm -rf .terraform .terraform.lock.hcl

show-outputs:
	# Show all Terraform outputs
	terraform output

refresh:
	@echo "Refreshing Terraform state from real infrastructure..."
	#this cammond is usefull when you stop the vm and restart it to get the new external IP address 
	terraform refresh
	terraform output -json > ./env/ansible_env_vars.json

