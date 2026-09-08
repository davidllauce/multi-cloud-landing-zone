mock_provider "aws" {}

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
}
