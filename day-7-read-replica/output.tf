output "primary_db_endpoint" {
  value = aws_db_instance.tr-db.endpoint
}

output "read_replica_endpoint" {
  value = aws_db_instance.tr-db-replica.endpoint
}

output "primary_db_arn" {
  value = aws_db_instance.tr-db.arn
}

output "read_replica_arn" {
  value = aws_db_instance.tr-db-replica.arn
}