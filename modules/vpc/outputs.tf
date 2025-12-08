output "vpc_id" {
  value = module.vpc_core.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc_core.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc_core.private_subnets
}
