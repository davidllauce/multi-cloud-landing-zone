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

variable "account_id" {
  description = "AWS account ID (used by the KMS key policy)"
  type        = string
  default     = "000000000000"
}

variable "tags" {
  description = "Additional tags for the S3 bucket"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Additional labels for the GCS bucket"
  type        = map(string)
  default     = {}
}
