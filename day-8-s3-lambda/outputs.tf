########################################
# S3 Bucket Outputs
########################################

output "s3_bucket_name" {
  description = "Name of the S3 bucket"
  value       = aws_s3_bucket.lambda_bucket.bucket
}

output "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  value       = aws_s3_bucket.lambda_bucket.arn
}

output "s3_object_key" {
  description = "Lambda ZIP file stored in S3"
  value       = aws_s3_object.app_zip.key
}

########################################
# IAM Outputs
########################################

output "lambda_role_name" {
  description = "IAM Role Name"
  value       = aws_iam_role.lambda_role.name
}

output "lambda_role_arn" {
  description = "IAM Role ARN"
  value       = aws_iam_role.lambda_role.arn
}

########################################
# Lambda Outputs
########################################

output "lambda_function_name" {
  description = "Lambda Function Name"
  value       = aws_lambda_function.lambda.function_name
}

output "lambda_function_arn" {
  description = "Lambda Function ARN"
  value       = aws_lambda_function.lambda.arn
}

output "lambda_invoke_arn" {
  description = "Lambda Invoke ARN"
  value       = aws_lambda_function.lambda.invoke_arn
}

output "lambda_last_modified" {
  description = "Lambda Last Modified Time"
  value       = aws_lambda_function.lambda.last_modified
}
