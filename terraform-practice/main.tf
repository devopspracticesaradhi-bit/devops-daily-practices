provider "aws" {
  region = "us-east-1"
}

# Fetch latest AMI ID for Amazon Linux 2
data "aws_ami" "name" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_vpc" "default" {
  default = true
  
}

data "aws_subnet_ids" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}



resource "aws_instance" "demo" {
  ami           = data.aws_ami.name.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]

  tags = {
    Name = "${var.environment}-${var.instance_name}"
  }
}
