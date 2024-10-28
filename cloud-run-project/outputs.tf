# Output en el nivel superior para mostrar los CNAMEs combinados de todas las instancias del módulo
output "dns_authorization_cnames_from_module" {
  description = "CNAMEs to add in your DNS provider from the DNS module"
  value       = flatten([for mod in module.certificate_manager : mod.dns_authorization_cnames])
}

