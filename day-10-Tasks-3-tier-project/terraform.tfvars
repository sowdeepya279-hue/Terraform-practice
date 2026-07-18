aws_region   = "us-east-1"
project_name = "sowdeepya-three-tier-project"

vpc_cidr = "10.0.0.0/16"

availability_zones = [
  "us-east-1a",
  "us-east-1b"
]

public_subnet_cidrs = [
  "10.0.1.0/24",
  "10.0.2.0/24"
]

private_subnet_cidrs = [
  "10.0.11.0/24",
  "10.0.12.0/24"
]

database_subnet_cidrs = [
  "10.0.21.0/24",
  "10.0.22.0/24"
]

ami_id        = "ami-01edba92f9036f76e"
instance_type = "t2.micro"
key_name      = "sow-key-pair"

db_username = "admin"
db_password = "admin12345!"