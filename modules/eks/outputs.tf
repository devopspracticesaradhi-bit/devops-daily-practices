output "cluster_name" {
  value = module.eks_core.cluster_name
}

output "cluster_endpoint" {
  value = module.eks_core.cluster_endpoint
}

output "cluster_ca_certificate" {
  value = module.eks_core.cluster_certificate_authority_data
}
