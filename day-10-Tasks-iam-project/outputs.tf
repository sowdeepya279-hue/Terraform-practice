output "iam_user_name" {
  value = aws_iam_user.developer.name
}

output "iam_group_name" {
  value = aws_iam_group.developers.name
}

output "developer_policy_arn" {
  value = aws_iam_policy.developer_policy.arn
}

output "ec2_role_name" {
  value = aws_iam_role.ec2_role.name
}

output "ec2_role_arn" {
  value = aws_iam_role.ec2_role.arn
}

output "instance_profile_name" {
  value = aws_iam_instance_profile.ec2_profile.name
}

output "ec2_instance_id" {
  value = aws_instance.iam_test.id
}

output "ec2_public_ip" {
  value = aws_instance.iam_test.public_ip
}

output "ec2_public_dns" {
  value = aws_instance.iam_test.public_dns
}