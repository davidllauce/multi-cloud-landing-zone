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

resource "aws_flow_log" "main" {
  iam_role_arn    = aws_iam_role.flow_log.arn
  log_destination = aws_cloudwatch_log_group.flow_log.arn
  traffic_type    = "ALL"
  vpc_id          = aws_vpc.main.id
  tags            = local.tags
}

resource "aws_kms_key" "flow_log" {
  description             = "KMS key for VPC flow log encryption"
  deletion_window_in_days = 10
  enable_key_rotation     = true
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Sid       = "Enable IAM User Permissions"
      Effect    = "Allow"
      Principal = { AWS = "arn:aws:iam::${var.account_id}:root" }
      Action    = "kms:*"
      Resource  = "*"
    }]
  })
  tags = local.tags
}

resource "aws_cloudwatch_log_group" "flow_log" {
  name              = "/aws/vpc/flow-log/${aws_vpc.main.id}"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.flow_log.arn
  tags              = local.tags
}

resource "aws_iam_role" "flow_log" {
  name = "vpc-flow-log-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect    = "Allow"
      Principal = { Service = "vpc-flow-logs.amazonaws.com" }
      Action    = "sts:AssumeRole"
    }]
  })
  tags = local.tags
}

resource "aws_iam_role_policy" "flow_log" {
  name = "vpc-flow-log-policy"
  role = aws_iam_role.flow_log.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"]
      Resource = ["arn:aws:logs:*:*:log-group:/aws/vpc/flow-log/*:log-stream:*"]
    }]
  })
}

resource "aws_default_security_group" "default" {
  vpc_id = aws_vpc.main.id
  tags   = local.tags
}
