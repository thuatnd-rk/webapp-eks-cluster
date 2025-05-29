terraform {
  backend "s3" {}
}

# Định nghĩa các biến locals để quản lý tên và tag chung
locals {
  project_name = "tidimove"
  environment  = "prod"
  
  # Tags chung cho tất cả tài nguyên
  common_tags = {
    Project     = local.project_name
    Environment = local.environment
    Terraform   = "true"
    Owner       = "DevOps-Team"
    ManagedBy   = "Terraform"
    CreatedAt   = timestamp()
  }
  
  # Tên cho các tài nguyên
  vpc_name     = "${local.project_name}-vpc"
  eks_name     = "${local.project_name}-eks"
  bastion_name = "${local.project_name}-bastion"
  rds_name     = "${local.project_name}-db"
  keypair_name = "${local.project_name}-keypair"
}

# ACM Certificate
module "acm" {
  source = "./modules/acm"
  rds_config = merge(var.rds_config, {
    tags = merge(var.amc_config.tags, local.common_tags)
  })
}

# VPC
module "vpc" {
  source     = "./modules/vpc"
  vpc_config = merge(var.vpc_config, {
    name = local.vpc_name
    tags = merge(var.vpc_config.tags, local.common_tags)
  })
}

# EKS
module "eks" {
  source     = "./modules/eks"
  eks_config = merge(var.eks_config, {
    cluster_name = local.eks_name
    tags = merge(var.eks_config.tags, local.common_tags)
  })

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.public_subnets
}

# Get latest Amazon Linux 2 AMI for bastion host
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Key pair
module "keypair" {
  source = "./modules/keypair"
  file_name = "/home/ndthuat/.ssh/${local.keypair_name}.pem"
  key_name = local.keypair_name
}

# Bastion Host Module
module "bastion" {
  source         = "./modules/bastion"
  bastion_config = merge(var.bastion_config, {
    name = local.bastion_name
    tags = merge(var.bastion_config.tags, local.common_tags,{
      Name = local.bastion_name
    })
  })

  vpc_id    = module.vpc.vpc_id
  subnet_id = module.vpc.public_subnets[0]
  ami_id    = data.aws_ami.amazon_linux.id
  key_name = module.keypair.key_name
}

# RDS PostgreSQL Module
module "rds" {
  source     = "./modules/rds"
  rds_config = merge(var.rds_config, {
    name = local.rds_name
    tags = merge(var.rds_config.tags, local.common_tags)
  })

  rds_password = var.rds_password
  vpc_id                   = module.vpc.vpc_id
  subnet_ids     = module.vpc.private_subnets
  bastion_security_group_id = module.bastion.bastion_security_group_id
}

