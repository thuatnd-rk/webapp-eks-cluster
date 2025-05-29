acm_config = {
  domain_name  = "learnaws.click"
  zone_id      = "Z064136625N1WQNZN5RU0"

  validation_method = "DNS"

  subject_alternative_names = [
    "*.learnaws.click",
  ]

  wait_for_validation = true

  tags = {}
}