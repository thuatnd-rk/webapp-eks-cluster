variable "eks_config" {
  description = "EKS cluster configuration"
  type = object({
    cluster_name    = string
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

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs"
  type        = list(string)
}