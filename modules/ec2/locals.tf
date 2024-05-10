locals {
  name          = "${var.application_name}-bastion"
  internet_cidr = "0.0.0.0/0"
}
