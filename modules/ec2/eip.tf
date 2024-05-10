resource "aws_eip" "nat" {
  instance         = aws_instance.public-nat.id
  public_ipv4_pool = "amazon"

  tags = {
    Name = "${var.application_name}-nat-ip"
  }
}
