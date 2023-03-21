output "rds_hostname" {
  description = "RDS instance hostname"
  value       = aws_db_instance.events.address
  sensitive   = true
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.events.port
  sensitive   = true
}

output "rds_username" {
  description = "RDS instance root username"
  value       = aws_db_instance.events.username
  sensitive   = true
}
