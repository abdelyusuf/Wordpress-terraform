variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "vpc_cidr" {
  type    = string
  default = "10.0.0.0/16"
}

variable "subnet_cidr" {
  type    = string
  default = "10.0.1.0/24"
}

variable "name" {
  type    = string
  default = "my-vpc"
}

variable "ami" {
  type    = string
  default = "ami-0acc77abdfc7ed5a6" # Replace with your AMI ID
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "key_name" {
  type    = string
  default = "hakimwordpress"
}
