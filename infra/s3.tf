resource aws_s3_bucket bucket {
  bucket        = "www.${var.apex_domain}"
  force_destroy = true
  acl           = "public-read"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

data aws_iam_policy_document policy {
  statement {
    principals {
      type        = "*"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.bucket.arn}/*"]
  }
}

resource aws_s3_bucket_policy bucket_policy {
  bucket = aws_s3_bucket.bucket.id
  policy = data.aws_iam_policy_document.policy.json
}