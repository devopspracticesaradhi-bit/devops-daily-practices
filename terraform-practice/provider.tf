terraform {
    required_version = ">= 1.11.0"
    backend "s3" {
        bucket = "terraform-practice-bucket-saradhi"
        key    = "terraform-practice-bucket-saradhi/terraform-practice/"
        region = "us-east-1"
        encrypt = true 
        use_lockfile = true
    }
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 5.0"
        }
    }
  
}