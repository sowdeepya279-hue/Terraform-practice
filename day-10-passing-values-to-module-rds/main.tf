provider "aws" {
  region = var.aws_region
}

module "rds" {
  source = "../day-10-Terraform-module-rds-task"

  identifier = var.identifier

  engine         = var.engine
  engine_version = var.engine_version

  instance_class        = var.instance_class
  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage

  db_name  = var.db_name
  username = var.username
  password = var.password

  publicly_accessible = var.publicly_accessible
  multi_az            = var.multi_az

  tags = var.tags
}