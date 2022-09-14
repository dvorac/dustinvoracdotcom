data aws_acm_certificate cert {
  provider    = aws
  domain      = var.apex_domain
  statuses    = ["ISSUED"]
  most_recent = true
}