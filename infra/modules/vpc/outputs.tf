output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}


output "public_subnets" {
  description = "public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "private subnets"
  value       = module.vpc.private_subnets
}
