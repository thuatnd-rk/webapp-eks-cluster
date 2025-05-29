output "rds_instance_id" {
  description = "The ID of the RDS instance"
  value       = aws_db_instance.this.id
}

output "rds_instance_endpoint" {
  description = "The connection endpoint of the RDS instance"
  value       = aws_db_instance.this.endpoint
}

output "rds_instance_address" {
  description = "The address of the RDS instance"
  value       = aws_db_instance.this.address
}

output "rds_instance_port" {
  description = "The port of the RDS instance"
  value       = aws_db_instance.this.port
}

output "rds_security_group_id" {
  description = "The ID of the RDS security group"
  value       = aws_security_group.rds.id
}