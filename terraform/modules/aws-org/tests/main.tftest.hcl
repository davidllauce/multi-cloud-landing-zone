mock_provider "aws" {}

run "aws_org_creates_ou_and_scp" {
  assert {
    condition     = aws_organizations_organizational_unit.shared.name == "shared-services"
    error_message = "expected OU name shared-services"
  }

  assert {
    condition     = aws_organizations_policy.require_cost_center.type == "SERVICE_CONTROL_POLICY"
    error_message = "expected SCP type SERVICE_CONTROL_POLICY"
  }
}
