# gcp-network

Environment-level GCP networking: a Shared VPC host network with subnets, an HA
VPN gateway, a Cloud Router, and Cloud NAT.

Used per environment (`dev`, `stg`, `prd`). GCP VPC resources do not support
`labels` in the Terraform provider; labeling is applied at the project or
organization level.
