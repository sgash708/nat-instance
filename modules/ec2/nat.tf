resource "aws_instance" "public-nat" {
  ami                         = "ami-0bdd30a3e20da30a1"
  instance_type               = "t2.micro"
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = [var.default_sg_id, aws_security_group.nat.id]
  associate_public_ip_address = true
  source_dest_check           = false
  key_name                    = aws_key_pair.publickey.id
  user_data                   = file("./modules/ec2/sh/nat_setup.sh")

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = "${var.application_name}-nat"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
