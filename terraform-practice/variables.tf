variable "region" {
    description = "The AWS region to deploy resources in"
    type        = string
    default     = "us-east-1"
}

variable "instance_name" {
  description = "Name of the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 type"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "Please declare your ENV"
  type = string
}

variable "key_name" {
  description = "Enter your key"
  type = string
}

variable "private_key_path" {
  description = "Enter your path"
  type = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {
    Environment = "dev"
    Owner       = "Saradhi"
  }
}
