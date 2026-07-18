variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = ""
}

variable "iam_user_name" {
  description = "IAM user name"
  type        = string
}

variable "iam_group_name" {
  description = "IAM group name"
  type        = string
}

variable "developer_policy_name" {
  description = "IAM policy name for developers"
  type        = string
}

variable "ec2_role_name" {
  description = "IAM role name for EC2"
  type        = string
}

variable "ec2_policy_name" {
  description = "IAM policy name attached to EC2 role"
  type        = string
}

variable "instance_profile_name" {
  description = "IAM instance profile name"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket used for testing IAM permissions"
  type        = string
}

variable "ec2_ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "ec2_instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "ec2_name" {
  description = "Name tag for EC2 instance"
  type        = string
}

variable "department" {
  description = "Department tag for IAM user"
  type        = string
}

variable "managed_by" {
  description = "Resource management tag"
  type        = string
}