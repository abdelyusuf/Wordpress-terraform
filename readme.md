# WordPress on AWS using Terraform

## Introduction

This project sets up a WordPress website hosted on Amazon Web Services (AWS) using Terraform. It automates the deployment of the necessary infrastructure, including an EC2 instance, security groups, and networking components, allowing you to quickly and easily launch your WordPress site in the cloud.

### Features

- **Infrastructure as Code**: The entire setup is defined in Terraform configuration files, making it easy to version control and replicate.
- **Automated Deployment**: With just a few commands, you can provision your infrastructure and have a running WordPress site.
- **Cost-Effective**: Utilize AWS resources efficiently, ensuring you only pay for what you use.
- **Customizable**: Easily modify the Terraform scripts to suit your specific requirements, whether you need additional resources or different configurations.

### Prerequisites

- An AWS account
- Terraform installed on your local machine
- Basic knowledge of AWS and Terraform
## Architecture Overview

This project leverages several AWS components to deploy WordPress, including:

- **Amazon EC2**: The virtual server that will host your WordPress application.
- **Amazon VPC**: Virtual Private Cloud for secure networking.
- **Elastic IP**: For a static public IP address to your EC2 instance.

## Setup Instructions

Follow these steps to set up your WordPress site on AWS:

1. **Clone the Repository**
   ```bash
   git clone https://github.com/abdelyusuf/Wordpress-terraform.git
   cd your-repo-name

  ## 2. Modify Variables
Update the ```variables.tf``` file (if you have one) to set your desired configurations such as AWS region, AMI ID, instance type, and key name.
Initialize Terraform
Run the following command to initialize the Terraform working directory:

## 3. Initialize Terraform
Run the following command to initialize the Terraform working directory:
```Terraform init``` 

## 4. Plan the Deployment
Execute the command below to see the resources that Terraform will create:
``` Terraform plan```
## 5. Apply the Configuration
Apply the Terraform configuration to provision the resources:
```Terraform apply```
Confirm the action when prompted.

## 6. Access Your WordPress Site
Once the deployment is complete, Terraform will output the public IP address of your WordPress instance. You can access your WordPress site using this IP address in your web browser.

 ## Cloud-init Script

The project includes a cloud-init.sh script that automates the setup of the WordPress environment on the EC2 instance. Here’s a brief overview of what it does:

Updates installed packages.
Installs Apache and MariaDB.
Sets up PHP with the necessary modules.
Downloads and configures WordPress.
Sets appropriate permissions for Apache to access WordPress files.

## Example Cloud-init Script
```#!/bin/bash

# Update all installed packages
yum update -y

# Install Apache
yum install -y httpd
systemctl start httpd
systemctl enable httpd

# Install MariaDB 10.5 and PHP with necessary modules
yum install -y mariadb105-server php php-mysqlnd
systemctl start mariadb
systemctl enable mariadb

# Remove Apache's default "It works!" page
rm -f /var/www/html/index.html

# Download and set up WordPress
cd /var/www/html
wget https://wordpress.org/latest.tar.gz
tar -xzf latest.tar.gz
mv wordpress/* ./
rm -rf wordpress latest.tar.gz

# Set permissions for Apache to access WordPress files
chown -R apache:apache /var/www/html/
chmod -R 755 /var/www/html/

# Restart Apache to ensure changes are applied
systemctl restart httpd
```
## Terraform Configuration

This project includes a main.tf file that defines the infrastructure for your WordPress site.

## Example main.tf
```module "vpc" {
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
```

## Outputs

After applying the Terraform configuration, you will receive the following outputs:

Instance ID: The unique identifier for your EC2 instance.
Instance Public IP: The public IP address to access your WordPress site.
Elastic IP Public IP: The Elastic IP assigned to your EC2 instance.

## Cleanup

To destroy the resources created by Terraform, run the following command:

``` Terraform destroy```

Confirm the action when prompted.

## Conclusion

This project simplifies the process of deploying a WordPress site on AWS using Terraform, allowing for a cost-effective and efficient setup. You can customize and extend the Terraform scripts to fit your specific needs. Happy blogging!

## License

This project is licensed under the MIT License - see the LICENSE file for details.

