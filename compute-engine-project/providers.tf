# Configuración del proveedor de Google Cloud
provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}