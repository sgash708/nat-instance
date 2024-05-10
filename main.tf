module "vpc" {
  source = "./modules/vpc"

  application_name = var.application_name
  cidr             = var.cidr
  num_subnet       = length(var.private_subnet_cidr)

  nat_instance_id = module.ec2.nat_instance_id
}

module "ec2" {
  source = "./modules/ec2"

  application_name    = var.application_name
  private_subnet_cidr = var.private_subnet_cidr

  private_subnet_ids = module.vpc.private_subnet_ids
  public_subnet_id   = module.vpc.public_subnet_ids[1]
  default_sg_id      = module.vpc.default_sg_id
  vpc                = module.vpc.main
}
