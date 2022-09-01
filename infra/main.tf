provider aws {
  region  = var.region
  profile = var.profile
}

terraform {
  backend "s3" {}
}