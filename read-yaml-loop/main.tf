
locals {
  config = yamldecode(file("config2.yaml"))
}

provider "google" {
  project = config.project.id
  region  = config.project.region
}

resource "google_storage_bucket" "bucket" {
  for_each = toset(config.buckets)

  name          = each.value.name
  location      = each.value.location
  force_destroy = each.value.force_destroy
}
