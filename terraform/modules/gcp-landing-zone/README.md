# gcp-landing-zone

GCP organization-level foundation: folder (`shared-services`), Shared VPC host
network with subnets, HA VPN gateway, Cloud Router and Cloud NAT.

Folder-level resources (`google_folder`) are **plan-only** and require a real GCP
Organization. The Shared VPC / HA VPN / Cloud NAT network runs on GCP emulators.

> **Labels:** GCP VPC resources (`google_compute_network`, subnetwork, router,
> HA VPN gateway, NAT) do not support `labels` in the Terraform provider. Labeling
> for FinOps/governance is applied at the project or organization level, not on
> individual VPC resources.
