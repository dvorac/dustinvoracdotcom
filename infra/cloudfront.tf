# see https://github.com/hashicorp/learn-terraform-cloudflare-static-website/blob/beb9be189b0dad2b6842768b15b3636c4659690a/main.tf
resource "aws_cloudfront_distribution" "distribution" {
  # https://stackoverflow.com/a/52077634
  provider = aws

  origin {
    # https://stackoverflow.com/a/41132075
    domain_name = aws_s3_bucket_website_configuration.www.website_endpoint
    origin_id   = aws_s3_bucket.www.id

    # https://stackoverflow.com/a/55042824
    custom_origin_config {
      http_port              = 80
      https_port             = 443
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1", "TLSv1.1", "TLSv1.2"]
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = ""
  default_root_object = "index.html"
  price_class         = "PriceClass_100"

  aliases = ["www.${var.apex_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = aws_s3_bucket.www.id
    compress         = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 86400
    max_ttl                = 31536000
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.cert.arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }
}