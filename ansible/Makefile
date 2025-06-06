# Ansible automation Makefile

# Color Definitions
GREEN := \033[0;32m
BLUE := \033[0;34m
NC := \033[0m # No Color (reset)


# all: inventory install-deps deploy check
all: inventory install-deps 

install-deps:
	@echo "${GREEN}>>>> Running install-deps${NC}"
	@echo "$(BLUE)For sudo password check terraform.tfvars for ssh_password in terraform folder$(NC)"
	@ansible-playbook -i ./inventory.yaml /home/khaoula/cloud_1/ansible/roles/deploy.yaml  --ask-become-pass


clean:
	@echo "${GREEN}>>>> Running clean${NC}"
	@echo "$(BLUE)For sudo password check terraform.tfvars for ssh_password in terraform folder$(NC)"
	@ansible-playbook -i ./inventory.yaml /home/khaoula/cloud_1/ansible/roles/clean-app-deployment-playbook.yaml  --ask-become-pass


inventory:
	@echo  "${GREEN}>>> Running inventory generation${NC}"
	@# Define inventory from terraform outputs
	@rm -rf inventory.yaml
	@bash ./generate_inventry.sh
