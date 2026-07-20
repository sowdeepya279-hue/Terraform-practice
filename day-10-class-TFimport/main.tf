resource "aws_instance" "tr-instance" {
  ami = "ami-01edba92f9036f76e"
instance_type = "t3.micro"
  tags = {
    Name = "sow-TF-import"
  }

}
#terraform import aws_instance.tr-instance i-0dfd186d0a721f49b

resource "aws_s3_bucket" "name" {
  bucket = "wos08-bucket"
}

resource "aws_s3_bucket_versioning" "name" {
    bucket = aws_s3_bucket.name.id
    versioning_configuration {
        status = "Enabled"
    }
  
}