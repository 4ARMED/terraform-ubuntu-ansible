output "public_ip" {
  description = "The public IP address of the collaborator server."
  value = "${aws_instance.ubuntu.public_ip}"
}
