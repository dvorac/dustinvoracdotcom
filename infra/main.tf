# following https://medium.com/@jerome.decoster/github-actions-hugo-terraform-s3-bc4609cedb1
# see: https://github.com/jeromedecoster/github-actions-hugo-terraform-s3
provider aws {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "s3" {}
}