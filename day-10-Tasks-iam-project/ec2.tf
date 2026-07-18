data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = var.instance_profile_name

  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "iam_test" {
  ami           = var.ec2_ami_id
  instance_type = var.ec2_instance_type

  subnet_id = data.aws_subnets.default.ids[0]

  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  tags = {
    Name      = var.ec2_name
    ManagedBy = var.managed_by
  }
}