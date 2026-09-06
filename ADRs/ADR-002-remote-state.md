# ADR-002: Remote state in GCS and S3

- Status: accepted
- Deciders: David Llauce

## Context

Terraform state must be stored remotely with encryption and versioning; local
state is unsafe for any shared environment.

## Decision

Use GCS (GCP) and S3 (AWS) buckets provisioned by a dedicated `backend` module,
with versioning, lifecycle rules, encryption, and public-access blocking. Each
environment points its `terraform { backend }` block to the corresponding bucket.

## Alternatives considered

- **Terraform Cloud / HCP** — rejected: adds an external dependency.
- **Single provider for state** — rejected: keeps state colocated with the cloud
  that owns the resources.

## Consequences

- State is versioned and recoverable; the backend module is reusable.
- Buckets are provisioned once (bootstrap) before the first apply.
