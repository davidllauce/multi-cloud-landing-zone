variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID that hosts the state buckets"
  type        = string
  default     = "dll-bootstrap"
}

variable "gcp_region" {
  description = "GCP region (GCS location)"
  type        = string
  default     = "us-central1"
}

variable "gcs_state_bucket" {
  description = "GCS bucket name for Terraform state"
  type        = string
  default     = "dll-tfstate"
}

variable "s3_state_bucket" {
  description = "S3 bucket name for Terraform state"
  type        = string
  default     = "dll-tfstate"
}
