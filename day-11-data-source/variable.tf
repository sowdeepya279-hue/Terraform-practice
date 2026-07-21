variable "project_name" {
  type = string
}

variable "subnet_name" {
  description = "Name tag of the subnet to search"
  type        = string
  default     = "public-subnet-1"

}

variable "security_group_name" {
  description = "Name tag of the security group to search"
  type        = string
  default     = "my-security-group"
}

variable "ami_name_filter" {
  description = "AMI name pattern"
  type        = string
  default     = "al2023-ami-*-x86_64"
}

variable "ami_owner" {
  description = "AMI owner ID"
  type        = list(string)
  default     = ["amazon"]
}
