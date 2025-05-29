output "bastion_id" {
  description = "The ID of the bastion host"
  value       = aws_instance.bastion.id
}

output "bastion_public_ip" {
  description = "The public IP of the bastion host"
  value       = aws_instance.bastion.public_ip
}

output "bastion_security_group_id" {
  description = "The ID of the bastion host security group"
  value       = aws_security_group.bastion.id
}