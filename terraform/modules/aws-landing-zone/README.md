# aws-landing-zone

AWS organization-level foundation: Organizational Unit + SCP (cost-center
enforcement), shared VPC with public/private subnets, Internet Gateway and
Transit Gateway.

Org-level resources (`aws_organizations_*`) are **plan-only** and require a real
AWS Organization. The VPC/Transit Gateway network runs on LocalStack.
