module "eks_core" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  cluster_endpoint_public_access = true

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  enable_irsa = true

  eks_managed_node_groups = {
    default = {
      name = var.node_group_name

      instance_types = [var.node_instance_type]

      min_size     = var.node_min_size
      max_size     = var.node_max_size
      desired_size = var.node_desired_size

      disk_size = 50

      labels = {
        role = "worker"
      }

      tags = {
        Name = var.node_group_name
      }
    }
  }
}
