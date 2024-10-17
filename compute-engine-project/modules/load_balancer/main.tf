

# Verificación de salud
resource "google_compute_health_check" "default" {
  for_each = { for idx, hc in var.health_checks : idx => hc }

  name = "${each.value.name}"

  http_health_check {
    request_path = each.value.request_path
    port         = each.value.port
  }
}


# Backend service para el Load Balancer
resource "google_compute_backend_service" "default" {
  name                  = "backend-service"
  protocol              = "HTTP"
  load_balancing_scheme = "EXTERNAL"
  dynamic "backend" {
    for_each = var.instance_groups

    content {
      group = backend.value
    }
  }
  # Configuración del logging
  log_config {
    enable      = var.logging_enable
    sample_rate = var.logging_sample_rate
  }
  health_checks = [for hc in google_compute_health_check.default : hc.self_link]
  security_policy = var.cloud_armor_policy
}

# URL Map para enrutar las solicitudes HTTP


resource "google_compute_url_map" "default" {
  name = var.load_balancer_name

  default_service = google_compute_backend_service.default.self_link
  host_rule {
    hosts        = [var.external_ip]
    path_matcher = "path-matcher"
  }
  path_matcher {
    name            = "path-matcher"
    default_service = google_compute_backend_service.default.self_link

    dynamic "path_rule" {
      for_each = var.url_paths
      content {
        paths   = [path_rule.value]
        service = google_compute_backend_service.default.self_link
      }
    }
  }
}

resource "google_compute_target_http_proxy" "http_proxy" {
  name        = "http-proxy"
  url_map     = google_compute_url_map.default.self_link
}

# HTTP Proxy para el Load Balancer
resource "google_compute_target_https_proxy" "default" {
  name    = "https-proxy"
  url_map = google_compute_url_map.default.self_link
  certificate_map="//certificatemanager.googleapis.com/${var.certificate}"
}

# Regla de reenvío global para dirigir el tráfico al HTTP Proxy
resource "google_compute_global_forwarding_rule" "default" {
  name       = "httpsforwarding-rule"
  target     = google_compute_target_https_proxy.default.self_link
  port_range = "443"
  ip_address = var.external_ip


}

resource "google_compute_global_forwarding_rule" "http_forwarding_rule" {
  name       = "http-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy.self_link
  port_range = "80"
  ip_address = var.external_ip
}


