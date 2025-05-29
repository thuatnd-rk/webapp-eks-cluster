variable "bastion_config" {
  description = "Bastion host configuration"
  type = object({
    name                    = optional(string)
    instance_type           = string
    allowed_ssh_cidr_blocks = list(string)
    root_volume_size        = number
    tags                    = map(string)
  })
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID where the bastion host will be deployed"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the bastion host"
  type        = string
}

variable "key_name" {
  description = "Key pair name for the bastion host"
  type        = string
}