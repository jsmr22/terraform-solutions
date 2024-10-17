output "private_key" {
  value       = google_service_account_key.this.private_key
  description = "The service account's private key encoded in Base64"
  sensitive   = true
}

output "name" {
  value       = google_service_account.this.name
  description = "The fully-qualified name of the service account."
}

output "email" {
  value       = google_service_account.this.email
  description = "The e-mail address of the service account."
}