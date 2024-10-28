terraform {
  backend "gcs" {
    bucket  = "terraform-state" # Nombre del bucket de GCS
    prefix  = "terraform/state" # Prefijo para organizar los archivos de estado
  }
}
