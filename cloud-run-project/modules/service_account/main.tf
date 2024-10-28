resource "google_service_account" "this" {
  project      = var.project_id
  account_id   = var.account_name
  display_name = var.display_name
}

resource "time_rotating" "key_rotation" {
  rotation_days = var.key_rotation_time
}

resource "google_service_account_key" "this" {
  service_account_id = google_service_account.this.name

  keepers = {
    rotation_time = time_rotating.key_rotation.rotation_rfc3339
  }
}

resource "google_project_iam_member" "this" {
  count = length(var.iam_roles)
  project = var.project_id
  role    = element(var.iam_roles, count.index)
  member  = "serviceAccount:${google_service_account.this.email}"
}