resource "aws_s3_bucket" "child_state_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = "Terraform Child State Bucket"

  }
}
