locals {
    lifecycle_rules = {
        "Delete" = 3
        "AbortIncompleteMultipartUpload" = 1
    }
}

resource "google_storage_bucket" "bucket" {
  name          = "my-awesome-bucket"
  location      = "EU"
  force_destroy = false

  dynamic "lifecycle_rule" {
    for_each = local.lifecycle_rules

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
