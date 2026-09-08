# ADR-003: Zero-trust credentials with Workload Identity Federation / OIDC

- Status: accepted
- Deciders: David Llauce

## Context

Deploying to AWS and GCP requires credentials. Static service-account keys or
long-lived access keys are a security risk (secrets in repos and CI). The target
is zero static credentials, aligning with ISO 27001 and a zero-trust posture.

## Decision

Never store cloud credentials in the repository or in `providers.tf`. Instead:

- **Local development** uses the default credential chain: `gcloud auth
  application-default login` (GCP) and `AWS_PROFILE`/environment variables (AWS).
  `terraform validate`, `test`, and non-authenticated `plan` run without
  cloud API access.
- **CI (plan / apply)** uses federated identity injected by GitHub Actions from
  short-lived tokens:
  - GCP via **Workload Identity Federation** (`google-github-actions/auth@v2`) —
    no service-account keys.
  - AWS via **OIDC** with `aws-actions/configure-aws-credentials@v4` (web
    identity) — no long-lived access keys.

The CI workflow reads the secrets from `secrets.*`. If the WIF/OIDC secrets are
not configured, the `plan`/`apply` steps are skipped (the pipeline stays green
until a real organization is available).

## Alternatives considered

- **Service-account key JSON / AWS access keys in CI** — rejected: static
  secrets, violates zero-trust.
- **Hardcoding `assume_role`/`impersonate_service_account` in `providers.tf`** —
  rejected: brittle and breaks local `plan` without credentials.

## Consequences

- Zero static credentials: the repository never contains keys.
- `validate`/`test` run without cloud access; `plan`/`apply` run only when
  federated identity is configured.
- Applying to a real organization requires provisioning the WIF pool/provider
  (GCP) and the OIDC role (AWS), documented in the README.
