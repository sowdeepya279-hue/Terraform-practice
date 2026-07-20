aws_region = "us-east-1"

identifier = "terraform-module-rds"

engine         = "mysql"
engine_version = "8.0"

instance_class        = "db.t3.micro"
allocated_storage     = 20
max_allocated_storage = 100

db_name  = "applicationdb"
username = "admin"
#password = "MySecurePassword123!" #TF_VAR_password="YourStrongPassword in the bash terminal to avoid hardcoding sensitive information in the terraform.tfvars file."


publicly_accessible = false
multi_az            = false

tags = {
  Environment = "dev"
  Project     = "terraform-rds-module"
}