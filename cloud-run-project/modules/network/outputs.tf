output "global_addresses" {
  value = merge(
  { for name, addr in google_compute_global_address.independent_global_address : name => addr.address },
  { for name, addr in google_compute_address.independent_regional_address : name => addr.address }
  )
}
