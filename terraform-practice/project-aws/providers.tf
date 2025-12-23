terraform {
    required_version = ">= 1.0.0"
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
            region = var.region
  }
}

backend "s3" {
    bucket = "my-terraform-state-bucket"
    key    = "terraform-practice/terraform.tfstate"
    region = var.region
    aquire_lock = true
    encrypt = true
  }
}