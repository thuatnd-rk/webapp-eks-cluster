variable "rds_config" {
  description = "RDS instance configuration"
  type = object({
    name                  = optional(string)
    engine_version        = string
    instance_class        = string
    allocated_storage     = number
    max_allocated_storage = number
    username              = string
    multi_az              = bool
    backup_retention_period = number
    skip_final_snapshot   = optional(bool, false)
    tags                = map(string)
  })
}

variable "rds_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS instance"
  type        = list(string)
}

variable "bastion_security_group_id" {
  description = "Security group ID of the bastion host"
  type        = string
}