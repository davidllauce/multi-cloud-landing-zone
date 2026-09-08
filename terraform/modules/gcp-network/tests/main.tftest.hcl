mock_provider "google" {}

run "gcp_network_creates_network_subnets_and_nat" {
  assert {
    condition     = google_compute_network.main.name == "dll-shared-vpc"
    error_message = "expected network name dll-shared-vpc"
  }

  assert {
    condition     = google_compute_network.main.auto_create_subnetworks == false
    error_message = "expected auto_create_subnetworks false"
  }

  assert {
    condition     = length(google_compute_subnetwork.main) == 2
    error_message = "expected 2 subnetworks"
  }
}
