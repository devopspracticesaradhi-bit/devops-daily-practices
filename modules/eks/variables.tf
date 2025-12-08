variable "cluster_name" {
  type        = string
  description = "EKS cluster name"
}

variable "cluster_version" {
  type        = string
  description = "Kubernetes version"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where EKS lives"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnets for worker nodes"
}

variable "node_group_name" {
  type        = string
  description = "Name of the managed node group"
}

variable "node_instance_type" {
  type        = string
  description = "EC2 instance type for worker nodes"
}

variable "node_min_size" {
  type        = number
  description = "Min nodes"
}

variable "node_max_size" {
  type        = number
  description = "Max nodes"
}

variable "node_desired_size" {
  type        = number
  description = "Desired nodes"
}
