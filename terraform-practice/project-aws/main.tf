module "vpc" {
  source = "vpc-module"

  vpc_cidr = "10.0.0.0/16"
  public_subnet_cidrs  = ["10.0.1.0/24"]
  private_subnet_cidrs = ["10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  name_prefix = "my-vpc"
  aws_region  = "us-east-1"

  tags = {
    Owner = "Saradhi"
    Env   = "DEV"
  }
}

module "ec2" {
  source = "ec2-module"

  vpc_id          = module.vpc.vpc_id
  public_subnet   = module.vpc.public_subnet_ids[0]
  instance_type   = "t2.micro"
  ami_id          = "ami-0c55b159cbfafe1f0" # Replace with a valid AMI ID for your region
  aws_region      = "us-east-1"
  depends_on = [module.vpc]
  tags = {
    Owner = "Saradhi"
    Env   = "DEV"
  }
}