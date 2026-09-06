# Security

## Reporting a vulnerability

Please report security issues directly to <davidllaucesantos@gmail.com>. Do not
open a public issue.

## Posture

- Zero static credentials: CI uses Workload Identity / OIDC (no keys or JSONs).
- Remote state stored with encryption and versioning (see `ADRs/ADR-002`).
- Policy-as-code enforces mandatory labels on every resource (see `ADRs/ADR-001`).
