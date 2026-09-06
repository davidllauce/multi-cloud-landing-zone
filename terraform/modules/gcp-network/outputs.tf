output "network_id" {
  value = google_compute_network.main.id
}

output "network_name" {
  value = google_compute_network.main.name
}

output "subnet_ids" {
  value = { for k, s in google_compute_subnetwork.main : k => s.id }
}

output "ha_vpn_gateway_id" {
  value = google_compute_ha_vpn_gateway.main.id
}
