output "main" {
  value = aws_vpc.main
}

output "private_subnet_ids" {
  value = aws_subnet.privates[*].id
}

output "public_subnet_ids" {
  value = aws_subnet.publics[*].id
}

output "default_sg_id" {
  value = aws_default_security_group.main.id
}
