resource "aws_vpc" "sv-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "sow-custom-vpc"
  }
}

resource "aws_subnet" "sv-subnet" {
  vpc_id = aws_vpc.sv-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-west-2a"
  map_public_ip_on_launch = true
  tags = {
    Name = "sow-custom-subnet"
  }
}

resource "aws_subnet" "sv-subnet2" {
  vpc_id = aws_vpc.sv-vpc.id
  cidr_block = "10.0.2.0/24"
    availability_zone = "us-west-2b"
  tags = {
    Name = "sow-private-subnet2"
  }
}


resource "aws_internet_gateway" "sv-igw" {
  vpc_id = aws_vpc.sv-vpc.id
  tags = {
    Name = "sow-custom-igw"
  }
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.sv-vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.sv-igw.id

  }

  tags = {
    Name = "public-route-table"
  }

}

resource "aws_route_table_association" "public_assoc" {

  subnet_id = aws_subnet.sv-subnet.id

  route_table_id = aws_route_table.public_rt.id

}

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"

#   tags = {
#     Name = "nat-eip"
#   }
# }


resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.sv-subnet.id

  tags = {
    Name = "sow-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.sv-igw
  ]
}

resource "aws_route_table" "private_rt" {
 vpc_id = aws_vpc.sv-vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "private-route-table"
  }

}

resource "aws_route_table_association" "private_assoc" {

  subnet_id = aws_subnet.sv-subnet2.id

  route_table_id = aws_route_table.private_rt.id

}

resource "aws_security_group" "private_sg" {

  name = "private-ec2-sg"

  vpc_id = aws_vpc.sv-vpc.id

  ingress {

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = ["10.0.0.0/16"]

  }

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {

    Name = "private-sg"

  }

}

resource "aws_instance" "private_ec2" {

  ami = "ami-0fd6b4bfb40773c2d"

  instance_type = "t2.micro"

  subnet_id = aws_subnet.sv-subnet2.id

  vpc_security_group_ids = [
    aws_security_group.private_sg.id
  ]

  associate_public_ip_address = false

  key_name = "sow-keypair"

  tags = {

    Name = "Private-EC2"

  }

}


