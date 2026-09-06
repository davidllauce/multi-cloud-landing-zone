variable "environment" {
  description = "Environment (dev-poc, stg, prd)"
  type        = string
  default     = "dev-poc"
}

variable "uen" {
  description = "Business unit prefix"
  type        = string
  default     = "dll"
}

variable "team" {
  description = "Owning team (sre, data, platform)"
  type        = string
  default     = "sre"
}

variable "owner" {
  description = "Resource owner"
  type        = string
  default     = "david-llauce"
}

variable "cost_center" {
  description = "Cost center code"
  type        = string
  default     = "dll-sre"
}

variable "component" {
  description = "Functional component name"
  type        = string
  default     = "network"
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "Public subnet CIDRs"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  description = "Private subnet CIDRs"
  type        = list(string)
  default     = ["10.0.10.0/24", "10.0.11.0/24"]
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}

variable "organization_root_id" {
  description = "AWS Organization root ID (plan-only, needs real org)"
  type        = string
  default     = "r-0000"
}
