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
    description = "The instance type for the EC2 instance"
    type        = string
    default     = "t3.micro"
}

variable "ami" {
    description = "The AMI ID for the EC2 instance"
    type        = string
    default     = "ami-068c0051b15cdb816"
}

variable "tags" {
    description = "The tags for the ec2 machines"
    type        = map(string)
    default     = {
        "PROD" = "Instance-1"
        "QA"   = "Instance-2"
    }
}
