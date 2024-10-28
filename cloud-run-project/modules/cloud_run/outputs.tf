output "backend_service_ids" {
  description = "IDs de los backend services creados para los servicios de Cloud Run"
  value = {
  for service_name, backend in google_compute_backend_service.backend : service_name => backend.id
  }
}
