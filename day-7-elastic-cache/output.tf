output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public1.id,
    aws_subnet.public2.id
  ]
}

output "database_endpoint" {
  value = aws_db_instance.mysql.address
}

output "database_port" {
  value = aws_db_instance.mysql.port
}

output "redis_endpoint" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].address
}

output "redis_port" {
  value = aws_elasticache_cluster.redis.cache_nodes[0].port
}

output "security_group_id" {
  value = aws_security_group.database.id
}
