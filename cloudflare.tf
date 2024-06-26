resource "cloudflare_record" "root_domain" {
    zone_id = var.cloudflare_zone_id
    name = "minecraft"
    value = google_compute_instance.mcserver.network_interface.0.access_config.0.nat_ip
    type = "A"
    proxied = false
}

# resource "cloudflare_record" "mcserver_subdomain" {
#     zone_id = var.cloudflare_zone_id
#     name = "mcserver"
#     value = google_compute_instance.mcserver.network_interface.0.access_config.0.nat_ip
#     type = "A"
#     proxied = false
# }
