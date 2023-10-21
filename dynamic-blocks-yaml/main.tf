locals {
  config = yamldecode(file("config.yaml"))
}

resource "google_storage_bucket" "bucket" {
  name          = config.bucket.name
  location      = config.bucket.location
  force_destroy = config.bucket.force_destroy

  dynamic "lifecycle_rule" {
    for_each = config.bucket.lifecycle_rules

    content {
      action = {
        type = lifecycle_rule.key
      }
      condition {
        age = lifecycle_rule.value
      }
    }
  }
}
