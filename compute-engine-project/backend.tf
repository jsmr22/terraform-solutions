terraform {
  backend "gcs" {
    bucket  = "terraform-bucket-XXXX"
    prefix  = "terraform/state"
  }
}
