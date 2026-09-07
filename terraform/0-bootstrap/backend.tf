# Bootstrap state is stored locally until the GCS/S3 buckets exist (chicken-and-egg).
# After the first apply, move the state to the created bucket:
#
# terraform {
#   backend "gcs" {
#     bucket = "dll-tfstate"
#     prefix = "terraform/bootstrap"
#   }
# }
