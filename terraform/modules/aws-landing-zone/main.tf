locals {
  common_labels = {
    "dll-businessunit" = var.uen
    "dll-team"         = var.team
    "dll-owner"        = var.owner
    "dll-cost-center"  = var.cost_center
    "dll-component"    = var.component
    "env"              = var.environment
    "service"          = "vpc"
  }

  tags = merge(var.tags, local.common_labels)
}

resource "aws_organizations_organizational_unit" "shared" {
  name      = "shared-services"
  parent_id = var.organization_root_id
}

resource "aws_organizations_policy" "require_cost_center" {
  name = "require-cost-center"
  type = "SERVICE_CONTROL_POLICY"
  content = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid      = "RequireCostCenter"
      Effect   = "Deny"
      Action   = ["*"]
      Resource = ["*"]
      Condition = {
        StringNotLike = {
          "aws:RequestTag/dll-cost-center" = "*"
        }
      }
    }]
  })
}

resource "aws_vpc" "main" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags                 = local.tags
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}

resource "aws_subnet" "public" {
  for_each                = toset(var.public_subnet_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = each.value
  map_public_ip_on_launch = true
  availability_zone       = element(var.availability_zones, index(var.public_subnet_cidrs, each.value))
  tags                    = merge(local.tags, { "dll-subnet" = "public" })
}

resource "aws_subnet" "private" {
  for_each          = toset(var.private_subnet_cidrs)
  vpc_id            = aws_vpc.main.id
  cidr_block        = each.value
  availability_zone = element(var.availability_zones, index(var.private_subnet_cidrs, each.value))
  tags              = merge(local.tags, { "dll-subnet" = "private" })
}

resource "aws_ec2_transit_gateway" "main" {
  description = "Shared transit gateway"
  tags        = local.tags
}

resource "aws_ec2_transit_gateway_vpc_attachment" "main" {
  subnet_ids         = [for s in aws_subnet.private : s.id]
  transit_gateway_id = aws_ec2_transit_gateway.main.id
  vpc_id             = aws_vpc.main.id
  tags               = local.tags
}
