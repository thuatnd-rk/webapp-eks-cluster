module "eks_al2" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.eks_config.cluster_name
  cluster_version = var.eks_config.cluster_version

  cluster_addons = var.eks_config.cluster_addons

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = var.eks_config.eks_managed_node_groups

  # Enable OIDC provider for the cluster
  enable_cluster_creator_admin_permissions = var.eks_config.enable_cluster_creator_admin_permissions
  cluster_endpoint_public_access = var.eks_config.cluster_endpoint_public_access
  enable_irsa                              = var.eks_config.enable_irsa

  tags = var.eks_config.tags
}
