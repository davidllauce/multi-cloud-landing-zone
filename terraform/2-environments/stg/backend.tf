terraform {
  backend "gcs" {
    bucket = "dll-tfstate"
    prefix = "terraform/stg"
  }
}
