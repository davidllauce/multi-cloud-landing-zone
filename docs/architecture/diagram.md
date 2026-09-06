# Landing Zone Architecture

Single cloud-agnostic control plane (Terraform) applying the same foundation
across AWS and GCP.

```mermaid
graph TD
  subgraph AWS["AWS (LocalStack / plan-only)"]
    AORG[AWS Organization + SCPs]
    ATGW[Transit Gateway]
    AVPC[VPC - shared]
    AORG --> AVPC
    ATGW --> AVPC
  end

  subgraph GCP["GCP (emulator / plan-only)"]
    GORG[Fabric FAST folders + org policy]
    GVPC[Shared VPC - host]
    GVPN[HA VPN]
    GNAT[Cloud NAT]
    GORG --> GVPC
    GVPN --> GVPC
    GNAT --> GVPC
  end

  POLICY[OPA/Conftest - tags + naming 5-part] --> AWS
  POLICY --> GCP
  CI[CI: validate → test → plan + Infracost] --> POLICY
```

## Principles

- **Cloud as commodity:** identical OSS control plane (Terraform + OPA) for both
  providers; provider-specific resources only where the cloud genuinely differs.
- **Plan-only for org level:** AWS Organizations/SCPs and GCP folders/org policies
  require real orgs — modeled in Terraform, verified via `plan`, applied only in
  a real account.
- **Policy as code:** every resource must carry `dll-cost-center`, `dll-team`,
  `env` and follow 5-part naming; OPA rejects violations in CI.
