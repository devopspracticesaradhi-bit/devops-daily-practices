provider "aws" {
  region = var.region
}

resource "aws_instance" "my-test" {
  for_each = var.tags
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "my-ec2-terraform-instance-${each.key}"
    env  = var.environment
  }
}