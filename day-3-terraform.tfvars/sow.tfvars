ami_id = "ami-002192a70217ac181"
instance_type = "t2.micro"
tags = "default-name"

#My tfvars file name is sow.tfvars and it contains the values for the variables defined in the variable.tf file. The values are passed to the main.tf file during the terraform apply command using the -var-file flag.
# terraform apply -var-file="sow.tfvars"