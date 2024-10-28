resource "google_cloud_run_v2_service" "default" {
  for_each = { for service in var.cloud_run_services : service.name => service }

  name                = each.value.name
  location            = each.value.region
  deletion_protection = each.value.deletion_protection
  ingress             = each.value.ingress

  template {

    scaling {
      min_instance_count = each.value.min_instances
      max_instance_count = each.value.max_instances
    }

    vpc_access {
      connector= "projects/${var.project_id}/locations/${each.value.region}/connectors/${each.value.vpc_connector}"
      egress    = each.value.vpc_egress_settings  # Asegúrate de que este valor sea "ALL_TRAFFIC"
    }

    dynamic "containers" {
      for_each = each.value.containers
      content {
        name  = containers.value.name
        image = containers.value.image

        resources {
          limits = {
            "cpu"    = tostring(each.value.cpu)
            "memory" = tostring(each.value.memory)
          }
        }

        ports {
          container_port = containers.value.container_port
        }
        dynamic "env" {
          for_each = var.memorystore_host != "" ? ["REDIS_URL"] : []
          content {
            name  = "REDIS_URL"
            value = "redis://${var.memorystore_host}:6379"
          }
        }
        dynamic "env" {
          for_each = containers.value.environment_variables
          iterator = env_var
          content {
            name  = env_var.key
            value = env_var.value
          }
        }
        dynamic "env" {
          for_each = containers.value.secrets
          iterator = secret
          content {
            name = secret.value.env_name
            value_source {
              secret_key_ref {
                secret = secret.value.secret_name
                version  = secret.value.secret_version
              }
            }
          }
        }

        # Si tienes secretos, puedes agregarlos aquí
        # dynamic "secret_env" {
        #   for_each = containers.value.secrets
        #   iterator = secret
        #   content {
        #     name = secret.value.env_name
        #     value = {
        #       secret = secret.value.secret_name
        #       version = secret.value.secret_version
        #     }
        #   }
        # }
      }
    }
    revision="${each.value.name}-${each.value.revision_name}"
    service_account  = each.value.service_account
    timeout  = "${each.value.timeout_seconds}s"
  }
  dynamic "traffic" {
    for_each = each.value.traffic
    iterator = traffic_var
    content {
      type = traffic_var.value.type
      revision=traffic_var.value.revision
      percent = traffic_var.value.percent
    }
  }
}


resource "google_cloud_run_service_iam_member" "no_auth" {
  for_each = { for service in var.cloud_run_services : service.name => service if service.allow_unauthenticated }

  service  = google_cloud_run_v2_service.default[each.key].name
  location = google_cloud_run_v2_service.default[each.key].location
  role     = "roles/run.invoker"
  member   = "allUsers"  # Permitir acceso a usuarios no autenticados (todos)
}




# Crear una Network Endpoint Group (NEG) para cada servicio de Cloud Run
resource "google_compute_region_network_endpoint_group" "neg" {
  for_each = { for service in var.cloud_run_services : service.name => service }
  name      = "${each.value.name}-neg"
  region    = each.value.region
  network_endpoint_type = "SERVERLESS"
  cloud_run {
    service = each.value.name
  }
}

# Crear un backend para cada servicio de Cloud Run
resource "google_compute_backend_service" "backend" {
  for_each = { for service in var.cloud_run_services : service.name => service }
  name      = each.value.backend_name
  port_name = lower(each.value.backend_service_protocol)
  protocol  = each.value.backend_service_protocol

  backend {
    group = google_compute_region_network_endpoint_group.neg[each.key].id
  }
  security_policy="projects/${var.project_id}/global/securityPolicies/${each.value.backend_security_policy}"
}
/*
# Crear el load balancer HTTP(S) para cada servicio
resource "google_compute_url_map" "url_map" {
  for_each = google_cloud_run_service.services
  name            = "${each.value.name}-url-map"
  default_service = google_compute_backend_service.backend[each.key].id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  for_each = google_cloud_run_service.services
  name     = "${each.value.name}-http-proxy"
  url_map  = google_compute_url_map.url_map[each.key].id
}

# Crear una regla de reenvío para cada dominio y su servicio
resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  for_each = google_cloud_run_service.services
  name       = "${each.value.name}-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy[each.key].id
  port_range = "80"

  # El dominio para el servicio
  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}

# Configurar un certificado SSL para cada dominio (opcional, si necesitas HTTPS)
resource "google_compute_managed_ssl_certificate" "ssl_certificate" {
  for_each = google_cloud_run_service.services
  name     = "${each.value.name}-ssl-cert"
  domains  = [each.value.domain]  # Cada servicio tendrá su propio dominio
}
*/