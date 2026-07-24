resource "aws_instance" "ec2" {

  ami = "ami-002192a70217ac181"

  instance_type = "t2.micro"

}