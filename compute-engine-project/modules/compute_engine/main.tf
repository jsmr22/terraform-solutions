

locals {
  zonal_instances = flatten([
  for zone, instance_count in var.zones_instance_count : [
  for index in range(instance_count) : {
    zone   = zone
    number = index
  }
  ]
  ])
}

resource "google_compute_instance" "default1" {
  for_each = { for idx, instance in local.zonal_instances : idx => instance }

  name         = "${var.compute_engine_name}-${each.value.zone}-${each.value.number}"
  zone         = each.value.zone
  machine_type = var.compute_engine_type
  project      = var.project_id

  boot_disk {
    initialize_params {
      image = var.boot_disk_os
      size  = var.boot_disk_size
    }
  }

  metadata_startup_script = file(var.metadata_startup_script)

  // Disco adicional
  attached_disk {
    source = google_compute_disk.additional_disk[each.key].id
  }

  network_interface {
    subnetwork = var.subnetwork_name
  }
}

// Definición del disco adicional
resource "google_compute_disk" "additional_disk" {
  for_each = { for idx, instance in local.zonal_instances : idx => instance }

  name  = "${var.compute_engine_additional_disk_name}-${each.value.zone}-${each.value.number}"
  type  = var.compute_engine_additional_disk_type
  zone  = each.value.zone
  size  = var.compute_engine_additional_disk_size
}

resource "google_compute_instance_group" "instance_group" {
  for_each = toset(keys(var.zones_instance_count))

  name = "instance-group-${each.key}"
  zone = each.key

  instances = [
  for instance in google_compute_instance.default1 :
  instance.self_link
  if instance.zone == each.key
  ]

  named_port {
    name = "http"
    port = 80
  }
  named_port {
    name = "https"
    port = 443
  }
}
