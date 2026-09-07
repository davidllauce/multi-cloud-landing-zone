module "backend" {
  source = "../modules/backend"

  gcs_bucket_name = var.gcs_state_bucket
  s3_bucket_name  = var.s3_state_bucket
  region          = var.gcp_region
}
