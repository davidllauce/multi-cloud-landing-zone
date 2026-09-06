module "aws_landing_zone" {
  source = "../../modules/aws-landing-zone"

  environment = var.environment
  team        = var.team
}

module "gcp_landing_zone" {
  source = "../../modules/gcp-landing-zone"

  region = var.gcp_region
}

module "backend" {
  source = "../../modules/backend"

  gcs_bucket_name = var.gcs_state_bucket
  s3_bucket_name  = var.s3_state_bucket
  region          = var.gcp_region
}
