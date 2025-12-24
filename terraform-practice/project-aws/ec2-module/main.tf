resource "aws_instance" "this" {
  ami           = "ami-068c0051b15cdb816" # Replace with a valid AMI ID for your region
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = var.tags
}