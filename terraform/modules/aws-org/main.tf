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
        Null = {
          "aws:RequestTag/dll-cost-center" = "true"
        }
      }
    }]
  })
}
