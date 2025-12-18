variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
}

variable "environment" {
    description = "The environment for deployment (e.g., dev, staging, prod)"
    type        = string
    default     = "dev"
}

variable "instance_type" {
  description = "The type of AWS EC2 instance to create"
  type = string
  default = "t3.micro"
}

variable "ami" {
    description = "The default AMI ID"
    type = string
    default = "ami-068c0051b15cdb816"
}

