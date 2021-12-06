
terraform {
  backend "s3" {
    bucket = "company-terraform-state-bucket"
    region = "eu-central-1"
    key= "app-production/terraform.tfstate"
  }
}
