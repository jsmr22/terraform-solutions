//output "self_link" {
  //value = google_compute_instance.default1.self_link
//}

output "self_links" {
  value = { for key, group in google_compute_instance_group.instance_group : key => group.self_link }
}
