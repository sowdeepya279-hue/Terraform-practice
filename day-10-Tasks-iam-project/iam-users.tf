resource "aws_iam_user" "developer" {
  name = var.iam_user_name

  tags = {
    Department = var.department
    ManagedBy  = var.managed_by
  }
}

resource "aws_iam_user_group_membership" "developer_membership" {
  user = aws_iam_user.developer.name

  groups = [
    aws_iam_group.developers.name
  ]
}
