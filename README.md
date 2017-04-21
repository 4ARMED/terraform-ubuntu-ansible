# Terraform AWS Ubuntu skeleton config with Ansible

This is a basic Terraform configuration to fire up an AWS EC2 instance and run an Ansible playbook.

1. Generate an SSH keypair using `ssh-keygen -b 2048 -t rsa -C me@aws -f mykeypair`
2. Update the [terraform.tfvars]
3. Update the [playbook.yml]
4. `terraform apply`

NOTE: This will cost you money!
