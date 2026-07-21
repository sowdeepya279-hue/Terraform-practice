 data "aws_subnet" "subnet-1" {
  filter {
    name   = "tag:Name"
    values = ["${var.project_name}-${var.subnet_name}"] #fetch the subnet with the tag Name=my-project-public-subnet-1
  }
   
 }

data "aws_security_group" "sg" {
    filter {
        name   = "tag:Name"
        values =  ["${var.project_name}-${var.security_group_name}"] #fetch the security group with the tag Name=my-security-group
    }
}

data "aws_ami" "amzlinux-backend" {
  most_recent = true
  owners = [ "amazon" ]   #  owners = var.ami_owner
  filter {
    name = "name"
    values = [ "al2023-ami-*-x86_64" ]  #  values = [var.ami_name_filter]
  }
             filter {
    name = "root-device-type"
    values = [ "ebs" ]
  }
        filter {
    name = "virtualization-type"
    values = [ "hvm" ]
  }
  filter {
    name = "architecture"
    values = [ "x86_64" ]
  }
}

resource "aws_instance" "sow-ec2" {
    ami = data.aws_ami.amzlinux-backend.id
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.subnet-1.id
    vpc_security_group_ids = [ data.aws_security_group.sg.id ]

   tags = {
    Name = "${var.project_name}-ec2"
  }   
}

