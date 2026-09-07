variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "gcp_project_id" {
  description = "GCP project ID"
  type        = string
  default     = "dll-prd"
}

variable "gcp_region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "environment" {
  description = "Environment"
  type        = string
  default     = "prd"
}

variable "team" {
  description = "Owning team"
  type        = string
  default     = "sre"
}

variable "aws_vpc_cidr" {
  description = "AWS VPC CIDR block"
  type        = string
  default     = "10.30.0.0/16"
}

variable "aws_public_subnet_cidrs" {
  description = "AWS public subnet CIDRs"
  type        = list(string)
  default     = ["10.30.1.0/24", "10.30.2.0/24"]
}

variable "aws_private_subnet_cidrs" {
  description = "AWS private subnet CIDRs"
  type        = list(string)
  default     = ["10.30.10.0/24", "10.30.11.0/24"]
}

variable "gcp_network_name" {
  description = "GCP Shared VPC network name"
  type        = string
  default     = "prd-shared-vpc"
}

variable "gcp_subnets" {
  description = "GCP subnet definitions"
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    { name = "subnet-a", cidr = "10.30.1.0/24" },
    { name = "subnet-b", cidr = "10.30.2.0/24" },
  ]
}
