resource "google_folder" "shared" {
  display_name = "shared-services"
  parent       = var.folder_id
}
