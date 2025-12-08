output "cluster_name" {
  value = module.k8s.cluster_name
}

output "cluster_endpoint" {
  value = module.k8s.cluster_endpoint
}

output "vpc_id" {
  value = module.network.vpc_id
}
