# Crear el load balancer HTTP(S) para cada servicio
resource "google_compute_url_map" "url_map" {
  for_each = { for lb in var.load_balancers : lb.load_balancer_name => lb }

  name = each.value.load_balancer_name

  default_service = each.value.default_backend_service

  dynamic "host_rule" {
    for_each = each.value.host_rules
    content {
      hosts = host_rule.value.domain
      path_matcher = host_rule.value.name
    }
  }

  dynamic "path_matcher" {
    for_each = each.value.host_rules
    content {
      name = path_matcher.value.name
      default_service = each.value.default_backend_service

      dynamic "path_rule" {
        for_each = path_matcher.value.path_rules
        content {
          paths = path_rule.value.path

          # Aquí referenciamos el backend de forma dinámica
          service = path_rule.value.backend

          # Si el rewrite está habilitado, aplicamos la reescritura de URL con route_action
          dynamic "route_action" {
            for_each = path_rule.value.rewrite.enabled ? [1] : []
            content {
              url_rewrite {
                path_prefix_rewrite = path_rule.value.rewrite.rewrite_to
              }
            }
          }
        }
      }
    }
  }
}












# Crear proxy HTTP solo si http_rule es true
resource "google_compute_target_http_proxy" "http_proxy" {
  for_each = { for lb in var.load_balancers : lb.load_balancer_name => lb if lb.http_rule }

  name     = "${each.value.load_balancer_name}-http-proxy"
  url_map  = google_compute_url_map.url_map[each.key].id
}

# Crear una regla de reenvío HTTP solo si http_rule es true
resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  for_each = { for lb in var.load_balancers : lb.load_balancer_name => lb if lb.http_rule }

  name       = "${each.value.load_balancer_name}-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy[each.key].id
  port_range = "80"

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  ip_address = "projects/${var.project_id}/global/addresses/${each.value.ip_address}"
}

# Crear proxy HTTPS solo si https_rule es true
resource "google_compute_target_https_proxy" "https_proxy" {
  for_each = { for lb in var.load_balancers : lb.load_balancer_name => lb if lb.https_rule }

  name      = "${each.value.load_balancer_name}-https-proxy"
  url_map   = google_compute_url_map.url_map[each.key].id
  certificate_map="certificatemanager.googleapis.com/projects/${var.project_id}/locations/global/certificateMaps/${each.value.map_certificate}"
}

# Crear una regla de reenvío HTTPS solo si https_rule es true
resource "google_compute_global_forwarding_rule" "https_forwarding_rule" {
  for_each = { for lb in var.load_balancers : lb.load_balancer_name => lb if lb.https_rule }

  name       = "${each.value.load_balancer_name}-https-forwarding-rule"
  target     = google_compute_target_https_proxy.https_proxy[each.key].id
  port_range = "443"

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
  ip_address = "projects/${var.project_id}/global/addresses/${each.value.ip_address}"
}





/*
# Crear los backends para cada servicio de Cloud Run
resource "google_compute_backend_service" "backend" {
  for_each  = var.services
  name      = "${each.value.name}-backend"
  port_name = "http"
  protocol  = "HTTP"

  backend {
    group = each.value.neg
  }
}

# Crear el load balancer HTTP(S) para cada servicio
resource "google_compute_url_map" "url_map" {
  for_each = var.services
  name            = "${each.value.name}-url-map"
  default_service = google_compute_backend_service.backend[each.key].id
}

resource "google_compute_target_http_proxy" "http_proxy" {
  for_each = var.services
  name     = "${each.value.name}-http-proxy"
  url_map  = google_compute_url_map.url_map[each.key].id
}

# Crear una regla de reenvío para cada dominio y su servicio
resource "google_compute_global_forwarding_rule" "forwarding_rule" {
  for_each = var.services
  name       = "${each.value.name}-forwarding-rule"
  target     = google_compute_target_http_proxy.http_proxy[each.key].id
  port_range = "80"

  load_balancing_scheme = "EXTERNAL"
  ip_protocol           = "TCP"
}
*/
