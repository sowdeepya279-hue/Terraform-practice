resource "aws_instance" "name" {
    ami = var.ami_id
    instance_type = var.instance_type
    tags = {
        Name = var.tags
    }
  
}

resource "aws_s3_bucket_acl" "my_bucket" {
    bucket = var.bucket_name
    acl    = "private"
}