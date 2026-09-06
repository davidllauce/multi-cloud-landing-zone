variable "gcs_bucket_name" {
  description = "GCS bucket name for Terraform state"
  type        = string
}

variable "s3_bucket_name" {
  description = "S3 bucket name for Terraform state"
  type        = string
}

variable "region" {
  description = "Region (GCS location)"
  type        = string
  default     = "us-central1"
}

variable "tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}
