variable "instance_type" {
  description = "The type of EC2 instance to create"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the EC2 instance will be launched"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the EC2 instance"
  type        = map(string)
}