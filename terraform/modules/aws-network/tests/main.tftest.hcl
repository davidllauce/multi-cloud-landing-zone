mock_provider "aws" {
  mock_resource "aws_iam_role" {
    defaults = {
      arn = "arn:aws:iam::123456789012:role/vpc-flow-log-role"
    }
  }

  mock_resource "aws_cloudwatch_log_group" {
    defaults = {
      arn = "arn:aws:logs:us-east-1:123456789012:log-group:/aws/vpc/flow-log/vpc-123:*"
    }
  }

  mock_resource "aws_kms_key" {
    defaults = {
      arn = "arn:aws:kms:us-east-1:123456789012:key/1234abcd-12ab-34cd-56ef-1234567890ab"
    }
  }
}

run "aws_network_creates_vpc_subnets_and_tgw" {
  assert {
    condition     = aws_vpc.main.cidr_block == "10.0.0.0/16"
    error_message = "expected VPC CIDR 10.0.0.0/16"
  }

  assert {
    condition     = length(aws_subnet.public) == 2
    error_message = "expected 2 public subnets"
  }

  assert {
    condition     = length(aws_subnet.private) == 2
    error_message = "expected 2 private subnets"
  }

  assert {
    condition     = aws_ec2_transit_gateway.main.description == "Shared transit gateway"
    error_message = "expected transit gateway description"
  }

  assert {
    condition     = aws_flow_log.main.traffic_type == "ALL"
    error_message = "expected flow log traffic type ALL"
  }
}
