variable "ami" {
  description = "ami number"
  type        = string
}

variable "instance_type" {
  description = "instance type"
  type        = string
}
variable "key_name" {
  description = "key pair name"
  type        = string
}

variable "aws_region" {
  description = "aws region"
  type        = string
}