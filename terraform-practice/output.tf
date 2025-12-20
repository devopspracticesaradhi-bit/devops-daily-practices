output "instance_public_ip" {
  value = aws_instance.demo.public_ip
}

output "instance_id" {
  value = aws_instance.demo.id
}

output "vpc_id" {
  value = data.aws_vpc.default.id
}

output "subnet_ids" {
  value = data.aws_subnets.default.ids
}

output "private_key_pem" {
  value     = tls_private_key.saradhi.private_key_pem
  sensitive = true
}