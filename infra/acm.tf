data aws_acm_certificate cert {
  provider    = var.region
  domain      = var.domain
  statuses    = ["ISSUED"]
  most_recent = true
}