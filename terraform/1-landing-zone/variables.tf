variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID for the landing zone"
  type        = string
  default     = "dll-landing-zone"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "aws_organization_root_id" {
  description = "AWS Organization root ID"
  type        = string
  default     = "r-0000"
}

variable "gcp_org_id" {
  description = "GCP organization ID"
  type        = string
  default     = "000000000000"
}
