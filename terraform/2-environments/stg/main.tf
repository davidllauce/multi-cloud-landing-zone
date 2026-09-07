module "aws_network" {
  source = "../../modules/aws-network"

  environment          = var.environment
  team                 = var.team
  vpc_cidr             = var.aws_vpc_cidr
  public_subnet_cidrs  = var.aws_public_subnet_cidrs
  private_subnet_cidrs = var.aws_private_subnet_cidrs
}

module "gcp_network" {
  source = "../../modules/gcp-network"

  region       = var.gcp_region
  network_name = var.gcp_network_name
  subnets      = var.gcp_subnets
}
