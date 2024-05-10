variable "application_name" {
  type = string
}
variable "cidr" {
  type = string
}
variable "private_subnet_cidr" {
  type = list(string)
}
