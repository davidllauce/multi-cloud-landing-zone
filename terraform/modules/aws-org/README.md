# aws-org

AWS organization-level foundation: an Organizational Unit (`shared-services`) and
a Service Control Policy (`require-cost-center`) that denies resource creation
when the `dll-cost-center` tag is absent.

These resources require a real AWS Organization; they are modeled in Terraform
and verified via `plan`.
