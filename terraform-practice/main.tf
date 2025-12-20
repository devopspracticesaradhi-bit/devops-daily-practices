# Fetch latest Amazon Linux 2 AMI
data "aws_ami" "latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Fetch default VPC
data "aws_vpc" "default" {
  default = true
}

# Fetch default subnets
data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "tls_private_key" "saradhi" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "saradhi" {
   key_name   = "terraform-generated-key"
  public_key = tls_private_key.saradhi.public_key_openssh
}

# Create EC2 instance
resource "aws_instance" "demo" {
  ami           = data.aws_ami.latest.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]

# use the user-data file
  user_data = file("user-data.sh")
  key_name = aws_key_pair.saradhi.key_name

  tags = {
    Name = "${var.environment}-${var.instance_name}"
  }
}



resource "null_resource" "remote_setup" {
  depends_on = [ aws_instance.demo ]

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "ec2-user"
      private_key = aws_key_pair.saradhi.key_pair_id
      host        = aws_instance.demo.public_ip
    }

    inline = [
      "sudo systemctl enable httpd",
      "sudo systemctl restart httpd",
      "echo 'Provisioned by remote-exec' | sudo tee /var/www/html/info.txt"
    ] 
    
  }
  
}

# Run local-exec on your machine
resource "null_resource" "local_message" {
  depends_on = [null_resource.remote_setup]

  provisioner "local-exec" {
    command = "echo Web server deployed at ${aws_instance.demo.public_ip}"
}

}

