output "aws_cloudfront_distribution" {
  value = aws_cloudfront_distribution.distribution.id
}

output "aws_bucket" {
  value = aws_s3_bucket.www.bucket
}