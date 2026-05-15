terraform {
  backend "s3" {
    bucket         = "hm-infra-tfstate-haki-malai-us-east-1"
    key            = "production/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "hm-infra-tf-locks"
    encrypt        = true
  }
}

