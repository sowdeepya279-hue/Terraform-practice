resource "aws_vpc" "tr-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "sow-vpc"
  }
}

resource "aws_subnet" "tr-subnet1" {
  vpc_id = aws_vpc.tr-vpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
 # map_public_ip_on_launch = true
  tags = {
    Name = "sow-subnet1"
  }
}

resource "aws_subnet" "tr-subnet2" {
  vpc_id = aws_vpc.tr-vpc.id
  cidr_block = "10.0.2.0/24"
    availability_zone = "us-east-1b"
  tags = {
    Name = "sow-subnet2"
  }
}

resource "aws_security_group" "tr_sg" {
name = "sow-sg"
description = "Allow SSH and HTTP traffic"
vpc_id = aws_vpc.tr-vpc.id

  ingress {

    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

    tags = {
        Name = "sow-sg"
    }
}

resource "aws_route_table_association" "subnet-1" {

  subnet_id = aws_subnet.tr-subnet1.id
  route_table_id = aws_route_table.public_rt.id

}

resource "aws_route_table_association" "subnet-2" {

  subnet_id = aws_subnet.tr-subnet2.id

  route_table_id = aws_route_table.public_rt.id

}



resource "aws_internet_gateway" "tr-igw" {
  vpc_id = aws_vpc.tr-vpc.id
  tags = {
    Name = "sow-custom-igw"
  }
}

resource "aws_route_table" "public_rt" {
 vpc_id = aws_vpc.tr-vpc.id

  route {
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.tr-igw.id

  }

  tags = {
    Name = "public-route-table"
  }

}

resource "aws_db_subnet_group" "tr-subnet-group" {
  name = "sow-subnet-group"
  subnet_ids = [
    aws_subnet.tr-subnet1.id,
    aws_subnet.tr-subnet2.id
  ]
  tags = {
    Name = "sow-subnet-group"
  }
}


resource "aws_db_instance" "tr-db" {
  allocated_storage = 20
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  identifier = "sow-rds-instance"
  username = "admin"
  password = "Admin#2026"
#managed_master_user_password = true #enable password management by AWS Secrets Manager


  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot = true
  vpc_security_group_ids = [aws_security_group.tr_sg.id]
  db_subnet_group_name = aws_db_subnet_group.tr-subnet-group.name
  publicly_accessible = true
  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_retention_period = 7
  tags = {
    Name = "sow-rds-instance"
  }
}

resource "aws_db_instance" "tr-db-replica" {
  identifier = "sow-rds-replica"
  engine = "mysql"
  instance_class = "db.t3.micro"
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.tr-subnet-group.name
  vpc_security_group_ids = [aws_security_group.tr_sg.id]
  replicate_source_db = aws_db_instance.tr-db.arn
  skip_final_snapshot = true
  tags = {
    Name = "sow-rds-replica"
  }

  depends_on = [
    aws_db_instance.tr-db
  ]
}

# resource "aws_eip" "nat_eip" {
#   domain = "vpc"

#   tags = {
#     Name = "nat-eip"
#   }
# }


/*resource "aws_eip" "nat_eip" {
  domain = "vpc"

  tags = {
    Name = "nat-eip"
  }
}

resource "aws_nat_gateway" "nat" {

  allocation_id = aws_eip.nat_eip.id

  subnet_id = aws_subnet.tr-subnet1.id

  tags = {
    Name = "sow-nat-gateway"
  }

  depends_on = [
    aws_internet_gateway.tr-igw
  ]
}*/

/*resource "aws_route_table" "private_rt" {
 vpc_id = aws_vpc.tr-vpc.id

  route {

    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.nat.id

  }

  tags = {
    Name = "private-route-table"
  }

}*/





