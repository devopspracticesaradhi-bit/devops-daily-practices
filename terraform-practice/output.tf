output "vpc_id" {
  value = aws_vpc.main.id
  
}

output "aws_subnet_ids" {
  value = aws_subnet.main[*].id
  
}

output "instance_public_ip" {
  value = aws_instance.demo.public_ip
}

output "instance_id" {
  value = aws_instance.demo.id
}
