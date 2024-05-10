variable "application_name" {
  type = string
}
variable "private_subnet_ids" {
  type = list(string)
}
variable "public_subnet_id" {
  type = string
}
variable "default_sg_id" {
  type = string
}
variable "vpc" {
  type = object({
    id         = string
    cidr_block = string
  })
}
variable "private_subnet_cidr" {
  type = list(string)
}
