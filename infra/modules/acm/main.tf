# Usage with 
# resource "aws_acm_certificate" "tidimove" {
#   domain_name               = var.acm_config.domain_name
#   subject_alternative_names = var.acm_config.subject_alternative_names
#   validation_method         = var.acm_config.validation_method

#   tags = var.acm_config.tags

#   lifecycle {
#     create_before_destroy = var.acm_config.create_before_destroy
#   }
# }


# Usage with Route53 for DNS validation
module "acm" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  domain_name  = var.acm_config.domain_name
  zone_id      = var.acm_config.zone_id

  validation_method = var.acm_config.validation_method

  subject_alternative_names = var.acm_config.subject_alternative_names

  wait_for_validation = var.acm_config.wait_for_validation

  tags = var.acm_config.tags
}