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
