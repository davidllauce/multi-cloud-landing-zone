# ADR-001: Policy-as-code with OPA/Conftest

- Status: accepted
- Deciders: David Llauce

## Context

Every cloud resource must carry mandatory labels (`dll-cost-center`,
`dll-team`, `dll-owner`, `env`) to support FinOps and governance. Manual reviews
do not scale.

## Decision

Enforce label requirements with OPA policies evaluated by Conftest in CI. The
policy reads a Terraform plan (`resource_changes`) and checks both GCP `labels`
and AWS `tags`. A committed fixture plan validates the policy in CI.

## Alternatives considered

- **Checkov / tfsec** — rejected: focused on security, less flexible for custom
  label policies.
- **OPA Gatekeeper in-cluster** — rejected: Kubernetes-scoped, out of scope for
  a Terraform-only foundation.

## Consequences

- Violations block merges before apply.
- The policy is a single source of truth, shared by the AWS and GCP modules.
