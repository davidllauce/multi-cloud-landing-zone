resource "google_compute_network" "main" {
  name                    = var.network_name
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_subnetwork" "main" {
  for_each = { for s in var.subnets : s.name => s }

  name                     = each.value.name
  region                   = var.region
  network                  = google_compute_network.main.id
  ip_cidr_range            = each.value.cidr
  private_ip_google_access = true

  log_config {
    aggregation_interval = "INTERVAL_5_SEC"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_firewall" "allow_internal" {
  name    = "allow-internal"
  network = google_compute_network.main.name

  allow {
    protocol = "all"
  }

  source_ranges = [for s in var.subnets : s.cidr]
}

resource "google_compute_ha_vpn_gateway" "main" {
  name    = "dll-ha-vpn-gw"
  network = google_compute_network.main.id
  region  = var.region
}

resource "google_compute_router" "main" {
  name    = "dll-router"
  network = google_compute_network.main.id
  region  = var.region
}

resource "google_compute_router_nat" "main" {
  name                               = "dll-cloud-nat"
  router                             = google_compute_router.main.name
  region                             = var.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
