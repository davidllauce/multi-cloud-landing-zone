mock_provider "google" {}

run "gcp_org_creates_folder" {
  assert {
    condition     = google_folder.shared.display_name == "shared-services"
    error_message = "expected folder display_name shared-services"
  }
}
