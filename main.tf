
module "vpc" {
  source      = "./modules/vpc"
  vpc_cidr    = var.vpc_cidr
  subnet_cidr = var.subnet_cidr
  name        = var.name
}

module "ec2_instance" {
  source        = "./modules/ec2"
  aws_region    = var.aws_region
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
}

