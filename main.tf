
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

output "vpc_id" {
  value = module.vpc.vpc_id # Assuming you added an output for VPC ID in the VPC module
}

output "subnet_id" {
  value = module.vpc.subnet_id
}

output "security_group_id" {
  value = module.vpc.security_group_id
}

output "route_table_id" {
  value = module.vpc.route_table_id
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "instance_id" {
  value = module.ec2_instance.instance_id # Output for the EC2 instance ID
}

output "instance_public_ip" {
  value = module.ec2_instance.instance_public_ip # Output for the EC2 instance public IP
}

output "eip_public_ip" {
  value = module.ec2_instance.eip_public_ip # Output for the Elastic IP
}
