resource "aws_s3_bucket" "lambda_bucket" {

  bucket = "sow-lambda-code-bucket-12345"

  tags = {
    Name        = "Lambda Code Bucket"
    Environment = "Dev"
    Project     = "Lambda-S3"
  }

}
resource "aws_s3_bucket_versioning" "versioning" {

  bucket = aws_s3_bucket.lambda_bucket.id

  versioning_configuration {

    status = "Enabled"

  }

}
resource "aws_s3_bucket_public_access_block" "public_access" {

  bucket = aws_s3_bucket.lambda_bucket.id

  block_public_acls = true

  block_public_policy = true

  ignore_public_acls = true

  restrict_public_buckets = true

}
resource "aws_s3_object" "app_zip" {

  bucket = aws_s3_bucket.lambda_bucket.id

  key = "app.zip"

  source = "${path.module}/app.zip"

  etag = filemd5("${path.module}/app.zip")

}



resource "aws_iam_role" "lambda_role" {

  name = "terraform-lambda-role"

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
    Name = "Lambda-IAM-Role"
  }
}


resource "aws_iam_policy" "lambda_logging_policy" {

  name = "lambda-logging-policy"

  description = "Allow Lambda to write CloudWatch Logs"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "logs:CreateLogGroup",

          "logs:CreateLogStream",

          "logs:PutLogEvents"

        ]

        Resource = "*"

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "attach_logging_policy" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_logging_policy.arn

}

resource "aws_iam_policy" "lambda_s3_policy" {

  name = "lambda-s3-policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Action = [

          "s3:GetObject",

          "s3:ListBucket"

        ]

        Resource = [

          aws_s3_bucket.lambda_bucket.arn,

          "${aws_s3_bucket.lambda_bucket.arn}/*"

        ]

      }

    ]

  })

}

resource "aws_iam_role_policy_attachment" "attach_s3_policy" {

  role = aws_iam_role.lambda_role.name

  policy_arn = aws_iam_policy.lambda_s3_policy.arn

}

resource "aws_lambda_function" "lambda" {

  function_name = "terraform-lambda"

  role = aws_iam_role.lambda_role.arn

  handler = "app.lambda_handler"

  runtime = "python3.13"

  filename = "${path.module}/app.zip"

  source_code_hash = filebase64sha256("${path.module}/app.zip")

  timeout = 30

  memory_size = 128

}

