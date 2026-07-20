variable "state_bucket_name" {
  description = "Globally unique S3 bucket name"
  type        = string
}

variable "dynamodb_table_name" {
  description = "DynamoDB table name for Terraform locking"
  type        = string
}