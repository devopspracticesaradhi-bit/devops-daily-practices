data "aws_ami" "latest" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
    filter {
        name   = "virtualization-type"
        values = ["hvm"]
  
}
}

resource "aws_instance" "saradhi-test" {
  ami = data.aws_ami.latest.id
  instance_type = var.instance_type
  tags = {
    Name = "${var.environment}-${var.instance_name}"
  }
}