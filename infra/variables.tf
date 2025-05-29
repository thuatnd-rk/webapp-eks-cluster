# Region
variable "region" {
  type        = string
  description = "AWS region to deploy the resources"
}


# ACM Configuration
variable "acm_config" {
  description = "Configuration for the ACM module"
  type = object({
    domain_name = string
    zone_id = string
    validation_method = string
    subject_alternative_names = list(string)
    wait_for_validation = optional(bool, true)
    tags = map(string)
  })
}

# VPC Configuration
variable "vpc_config" {
  description = "Configuration for the VPC module"
  type = object({
    cidr                = string
    map_public_ip_on_launch = bool
    azs                 = list(string)
    private_subnets     = list(string)
    public_subnets      = list(string)
    enable_nat_gateway  = bool
    enable_vpn_gateway  = bool
    public_subnet_tags  = map(string)
    private_subnet_tags = map(string)
    tags                = map(string)
  })
}

# EKS Configuration
variable "eks_config" {
  description = "Cấu hình cho EKS cluster"
  type = object({
    cluster_version = string
    cluster_addons  = map(any)
    eks_managed_node_groups = map(object({
      ami_type       = string
      instance_types = list(string)
      min_size       = number
      max_size       = number
      desired_size   = number
    }))
    enable_cluster_creator_admin_permissions = bool
    enable_irsa                              = bool
    cluster_endpoint_public_access        = bool
    tags                = map(string)
  })
}

# Bastion Host Configuration
variable "bastion_config" {
  description = "Configuration for the bastion host"
  type = object({
    instance_type           = string
    allowed_ssh_cidr_blocks = list(string)
    root_volume_size        = number
    tags                = map(string)
  })
}

# RDS Configuration
variable "rds_config" {
  description = "Configuration for the RDS instance"
  type = object({
    engine_version          = string
    instance_class          = string
    allocated_storage       = number
    max_allocated_storage   = number
    username                = string
    multi_az                = bool
    backup_retention_period = number
    skip_final_snapshot     = bool
    tags                = map(string)
  })
}

# RDS Password
variable "rds_password" {
  description = "RDS master password"
  type        = string
  sensitive   = true
}