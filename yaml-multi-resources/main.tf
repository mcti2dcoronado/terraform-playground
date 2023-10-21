locals {
  config = yamldecode(file("config.yaml"))
}

resource "google_storage_bucket" "bucket" {
  name          = config.bucket.name
  location      = config.bucket.location
  force_destroy = config.bucket.force_destroy
}

resource "google_storage_bucket_iam_member" "admins" {
  for_each = toset(config.bucket.admins)

  bucket = google_storage_bucket.bucket.name
  role   = "roles/storage.admin"
  member = each.key
}

