variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "dll-dev-poc"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "dev-poc"
}

variable "team" {
  description = "Owning team"
  type        = string
  default     = "sre"
}

variable "gcs_state_bucket" {
  description = "GCS bucket for Terraform state"
  type        = string
  default     = "dll-dev-poc-tfstate"
}

variable "s3_state_bucket" {
  description = "S3 bucket for Terraform state"
  type        = string
  default     = "dll-dev-poc-tfstate"
}
