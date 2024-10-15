provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "this" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = var.key_name
  user_data     = file("${path.root}/cloud-init.sh")

  tags = {
    Name = "WordPress"
  }
}

output "instance_id" {
  value = aws_instance.this.id
}

output "instance_public_ip" {
  value = aws_instance.this.public_ip
}

resource "aws_eip" "this" {
  domain   = "vpc"
  instance = aws_instance.this.id

  tags = {
    Name = "WordPress EIP"
  }
}

output "eip_public_ip" {
  value = aws_eip.this.public_ip
}

