provider "aws" {
  region = "${var.region}"
  profile = "${var.profile}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_key_pair" "key" {
  key_name = "${var.key_name}"
  public_key = "${file("${var.key_name}.pem")}"
}

resource "aws_instance" "ubuntu" {
  ami = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_type}"
  key_name = "${aws_key_pair.key.key_name}"

  tags {
    Name = "${var.server_name}"
  }

  security_groups = [
    "${aws_security_group.ubuntu_sg.name}"
  ]

  provisioner "local-exec" {
    command = "sleep 30 && ansible-galaxy install -r requirements.yml && echo \"[ubuntu]\n${aws_instance.ubuntu.public_ip} ansible_connection=ssh ansible_ssh_user=ubuntu ansible_ssh_private_key_file=${var.key_name}\" > inventory && ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i inventory playbook.yml --extra-vars \"\""
  }
}

resource "aws_security_group" "ubuntu_sg" {
  name = "ubuntu-sg"
  description = "Allow access to Ubuntu server"

  # SSH
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["${var.permitted_ssh_cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
