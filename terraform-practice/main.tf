provider "aws" {
  region = var.region
}

resource "aws_instance" "my-test" {
  count = 3
  ami = var.ami
  instance_type = var.instance_type
  tags = {
    name = "my-ec2-terraform-instance-${count.index}"
    env = "Test"
  }
}

