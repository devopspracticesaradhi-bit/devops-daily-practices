output "instance_public_ip" {
  value = aws_instance.saradhi-test.public_ip
}

output "instance_id" {
  value = aws_instance.saradhi-test.id
}