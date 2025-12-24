module "vpc" {
  source = "./vpc-module" # Correct module path

  vpc_cidr             = "10.0.0.0/16"
  availability_zones   = ["us-east-1a", "us-east-1b"]
  public_subnets       = ["10.0.1.0/24"]
  private_subnets      = ["10.0.2.0/24"]

  tags = {
    Owner = "Saradhi"
    Env   = "DEV"
  }
}

module "ec2" {
  source = "./ec2-module" # Correct module path

  instance_type = "t3.micro"
  subnet_id     = module.vpc.public_subnet_ids[0] # Reference the first public subnet ID from the VPC module
  vpc_id        = module.vpc.vpc_id              # Pass the VPC ID from the VPC module

  tags = {
    Owner = "Saradhi"
    Env   = "DEV"
  }

  depends_on = [module.vpc] # Explicit dependency on the VPC module
}