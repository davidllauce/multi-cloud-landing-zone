locals {
  common_labels = {
    "dll-businessunit" = "dll"
    "dll-team"         = "platform"
    "dll-owner"        = "david-llauce"
    "dll-cost-center"  = "dll-platform"
    "dll-component"    = "state"
    "env"              = "bootstrap"
    "service"          = "terraform"
  }
}

module "backend" {
  source = "../modules/backend"

  gcs_bucket_name = var.gcs_state_bucket
  s3_bucket_name  = var.s3_state_bucket
  region          = var.gcp_region
  labels          = local.common_labels
  tags            = local.common_labels
}
