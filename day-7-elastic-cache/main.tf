resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "deepa-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}

resource "aws_subnet" "public1" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
 tags = {
    Name = "subnet1"
  }

}

resource "aws_subnet" "public2" {

  vpc_id = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
 tags = {
    Name = "subnet2"
  }

}

resource "aws_route_table" "public" {

  vpc_id = aws_vpc.main.id
  route {

    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }

}

resource "aws_route_table_association" "subnet1" {

  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table_association" "subnet2" {

  subnet_id = aws_subnet.public2.id
  route_table_id = aws_route_table.public.id

}

resource "aws_security_group" "database" {

  name = "database-sg"
  vpc_id = aws_vpc.main.id

  ingress {

    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {

    from_port = 6379
    to_port = 6379
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {

    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

}

resource "aws_db_subnet_group" "db_subnet" {

  name = "db-subnet-group"
  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

}

resource "aws_elasticache_subnet_group" "cache_subnet" {

  name = "cache-subnet"
  subnet_ids = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]

}

resource "aws_db_instance" "mysql" {
  identifier = "terraform-db"
  engine = "mysql"
  engine_version = "8.0"
  instance_class = "db.t3.micro"
  allocated_storage = 20
  db_name = "sowdb"
  username = "admin"

  password = "Sow#2026Secure"

  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  vpc_security_group_ids = [

    aws_security_group.database.id

  ]

  publicly_accessible = true
  skip_final_snapshot = true

}

resource "aws_elasticache_cluster" "redis" {

  cluster_id = "terraform-redis"
  engine = "redis"
  node_type = "cache.t3.micro"
  num_cache_nodes = 1
  parameter_group_name = "default.redis7"
  port = 6379

  subnet_group_name = aws_elasticache_subnet_group.cache_subnet.name

  security_group_ids = [

    aws_security_group.database.id

  ]

}
