# Remote state is provisioned by the `backend` module (terraform/modules/backend).
# Bootstrap once to create the GCS/S3 buckets, then uncomment the matching block
# and set the bucket name. State is never stored locally in production.
#
# terraform {
#   backend "gcs" {
#     bucket = "dll-dev-poc-tfstate"
#     prefix = "terraform/dll/dev-poc"
#   }
# }
