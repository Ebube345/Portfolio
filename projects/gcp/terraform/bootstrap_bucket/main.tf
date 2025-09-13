provider "google" {
  project = "semiotic-vial-471121-d0"
  region  = "us"
}

resource "google_storage_bucket" "tf_state" {
  name     = "ahiaplace-terragrunt-state"
  location = "US"
  force_destroy = true

  uniform_bucket_level_access = true
}
terraform {
  backend "local" {}
}