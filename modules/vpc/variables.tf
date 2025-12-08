variable "name_prefix" {
  type        = string
  description = "Prefix for VPC name"
}

variable "aws_region" {
  type        = string
  description = "AWS region (for AZs)"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR block"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "Public subnet CIDRs"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private subnet CIDRs"
}
