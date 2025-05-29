eks_config = {
  cluster_version = "1.32"

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  eks_managed_node_groups = {
    tidimove-prod = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]
      
      min_size     = 2
      max_size     = 2
      desired_size = 2
    }

    tidimove-monitor = {
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.small"]
      
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
  
  enable_cluster_creator_admin_permissions = true
  enable_irsa                              = true
  cluster_endpoint_public_access        = true

  tags = {}
}