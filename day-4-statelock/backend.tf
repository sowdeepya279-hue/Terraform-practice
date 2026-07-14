terraform {
  backend "s3" {
    bucket = "sow-bucket-123"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
