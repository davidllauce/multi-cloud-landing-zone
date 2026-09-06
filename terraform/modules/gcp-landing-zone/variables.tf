variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "network_name" {
  description = "Shared VPC network name"
  type        = string
  default     = "dll-shared-vpc"
}

variable "subnets" {
  description = "Subnet definitions"
  type = list(object({
    name = string
    cidr = string
  }))
  default = [
    { name = "subnet-a", cidr = "10.10.1.0/24" },
    { name = "subnet-b", cidr = "10.10.2.0/24" },
  ]
}

variable "folder_id" {
  description = "GCP folder ID (plan-only, needs real org)"
  type        = string
  default     = "000000000000"
}
