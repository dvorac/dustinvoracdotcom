# see https://github.com/hashicorp/learn-terraform-cloudflare-static-website/blob/020a13f169198de9a991d0922ef23f16a7ee4351/main.tf
resource aws_s3_bucket www {
  bucket        = "www.${var.apex_domain}"
  force_destroy = true
}

resource aws_s3_bucket_website_configuration www {
  bucket = aws_s3_bucket.www.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource aws_s3_bucket_acl www {
  bucket = aws_s3_bucket.www.id
  acl = "public-read"
}

resource aws_s3_bucket_policy www {
  bucket = aws_s3_bucket.www.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource = [
          aws_s3_bucket.www.arn,
          "${aws_s3_bucket.www.arn}/*",
        ]
      },
    ]
  })
}