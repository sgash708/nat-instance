resource "aws_iam_role" "ssm" {
  name               = "${local.name}-ssm"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.bastion.json
}

resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ssm.name
  policy_arn = data.aws_iam_policy.ssm.arn
}

resource "aws_iam_instance_profile" "bastion" {
  name = local.name
  role = aws_iam_role.ssm.name
}

resource "aws_key_pair" "publickey" {
  key_name   = "${local.name}-pem"
  public_key = file("./id_rsa.pem.pub")

  lifecycle {
    ignore_changes = [public_key]
  }
}

resource "aws_instance" "private-bastion" {
  ami                    = "ami-0bdd30a3e20da30a1"
  instance_type          = "t2.micro"
  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  subnet_id              = var.private_subnet_ids[1]
  vpc_security_group_ids = []
  key_name               = aws_key_pair.publickey.id
  user_data              = file("./modules/ec2/sh/bastion_setup.sh")

  credit_specification {
    cpu_credits = "standard"
  }

  tags = {
    Name = local.name
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
