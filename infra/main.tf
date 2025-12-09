module "network" {
  source = "../modules/vpc"

  name_prefix = var.project_name
  aws_region  = var.aws_region

  vpc_cidr = "10.0.0.0/16"

  public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
}

module "k8s" {
  source = "../modules/eks"

  cluster_name    = "${var.project_name}-cluster"
  cluster_version = "1.30"

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnet_ids

  node_group_name   = "${var.project_name}-ng"
  node_instance_type = "t3.small"
  node_min_size      = 2
  node_max_size      = 4
  node_desired_size  = 2
}
