resource "aws_s3_bucket" "bucket" {
    bucket = "wos123bucket"
    provider = aws.dev-account
  
}

resource "aws_s3_bucket" "wos-bucket" {
    bucket = "wosme123bucket"
    provider = aws.prod-account
  
}