data "aws_route53_zone" "domain" {
  provider = aws
  name     = "${var.apex_domain}."
}

resource "aws_route53_record" "ipv4" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "www.${var.apex_domain}"
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "ipv6" {
  zone_id = data.aws_route53_zone.domain.zone_id
  name    = "www.${var.apex_domain}"
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.distribution.domain_name
    zone_id                = aws_cloudfront_distribution.distribution.hosted_zone_id
    evaluate_target_health = false
  }
}