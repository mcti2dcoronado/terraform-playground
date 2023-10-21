locals {
  config = yamldecode(file("config.yaml"))
}

provider "google" {
  project = config.project.id
  region  = config.project.region
}

resource "google_storage_bucket" "bucket" {
  name          = config.bucket.name
  location      = config.bucket.location
  force_destroy = config.bucket.force_destroy
}
