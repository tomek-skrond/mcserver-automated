resource "google_compute_network" "vpc_network" {
  name                    = "infra"
  auto_create_subnetworks = true
  mtu                     = 1460
}

resource "google_compute_subnetwork" "server" {
  name          = "server-subnet"
  ip_cidr_range = "10.0.3.0/24"
  region        = var.region
  network       = google_compute_network.vpc_network.id
}