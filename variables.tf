variable "region" {
  description = "The AWS region."
}

variable "profile" {
  description = "The AWS credentials profile to use."
  default     = "default"
}

variable "instance_type" {
  description = "The AWS instance type to use."
}

variable "key_name" {
  description = "The AWS SSH keypair to use."
}

variable "server_name" {
  description = "The name of the server (will be used in the Name tag on AWS)."
}

variable "permitted_ssh_cidr_block" {
  description = "IP addresses from which SSH connections will be allowed. Default is all, which will be noisy."
  default = "0.0.0.0/0"
}
