# ADR-000: Multi-cloud landing zone with a single Terraform control plane

- Status: accepted
- Deciders: David Llauce

## Context

A reproducible, organization-level foundation is needed for workloads spanning
AWS and GCP. With no managed AWS Organization or GCP Organization available in
this environment, org-level resources are modeled in Terraform and verified via
`plan`, while the network foundation is validated locally against LocalStack and
GCP emulators.

## Decision

Model the landing zone as Terraform modules per provider (`aws-landing-zone`,
`gcp-landing-zone`), a shared `policy` module (OPA/Conftest), and a shared
`backend` module (remote state). Org-level resources (AWS Organizations/SCPs,
GCP folders/org policies) are declared in Terraform and verified via `plan`;
they are applied only in a real organization. The network foundation is
validated locally against LocalStack (AWS) and GCP emulators.

## Alternatives considered

- **Pulumi / AWS CDK** — rejected: Terraform is the team standard and
  `terraform plan` is a review artifact.
- **Two separate repos (one per cloud)** — rejected: a single control plane
  keeps the foundation consistent across clouds.
- **Live cloud with a budget** — rejected for cost; deferred as an optional
  "live apply" template.

## Consequences

- Org-level apply remains unverified locally (documented, plan-only).
- The network layer is fully reproducible locally.
- The policy module is cloud-agnostic and reused across both providers.
