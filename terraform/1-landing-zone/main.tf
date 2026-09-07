module "aws_org" {
  source = "../modules/aws-org"

  organization_root_id = var.aws_organization_root_id
}

module "gcp_org" {
  source = "../modules/gcp-org"

  folder_id = var.gcp_org_id
}
