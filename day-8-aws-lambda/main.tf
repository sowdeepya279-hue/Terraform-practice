resource "aws_iam_role" "lambda_role" {

  name = "sow-terraform-lambda-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "Sow-Lambda-IAM-Role"
  }
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {

  role = aws_iam_role.lambda_role.name

  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"

}

resource "aws_lambda_function" "sow_lambda_function" {

  function_name = "sow-lambda-function"
  runtime = "python3.12"
  role = aws_iam_role.lambda_role.arn
  handler = "lambda_function.lambda_handler"
  filename = "${path.module}/lambda_function.zip"
  source_code_hash = filebase64sha256("${path.module}/lambda_function.zip")
  timeout = 300
  memory_size = 128
}
