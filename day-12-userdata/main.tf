resource "aws_instance" "tr-instance" {
  ami = "ami-01edba92f9036f76e"
instance_type = "t2.medium"
user_data = file("userdata.sh")
  tags = {
    Name = "sow-instance"
  }
}