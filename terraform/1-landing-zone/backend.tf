terraform {
  backend "gcs" {
    bucket = "dll-tfstate"
    prefix = "terraform/landing-zone"
  }
}
