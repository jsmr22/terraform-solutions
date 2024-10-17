resource "google_sql_database_instance" "default" {
  count = var.database_enable ? 1 : 0
  name             = var.db_name
  database_version = var.db_version
  region=var.db_region
  project=var.project_id
  deletion_protection = false # set to true to prevent destruction of the resource
  settings {
    tier = var.database_tier
    ip_configuration {
      ipv4_enabled    = "false"
      private_network = var.network_id
    }
    disk_size=var.db_size
    availability_type=var.db_availability_type
    backup_configuration {
      enabled = true
      start_time = "03:00"
    }
    maintenance_window {
      day          = 7
      hour          = 0
      update_track  = "stable"
    }
  }

}