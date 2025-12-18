provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "my-test" {
  ami = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    name = "my-ec2-terraform-instance"
    env = "Test"
    
  }
}

