# ALLOW SSH 
resource "google_compute_firewall" "ssh" {
  name = "allow-ssh"

  allow {
    ports    = ["22"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["ssh"]
}
# ALLOW SERVER PORT 25565
resource "google_compute_firewall" "server" {
  name = "allow-server"

  allow {
    ports    = ["25565"]
    protocol = "tcp"
  }
  
  network       = google_compute_network.vpc_network.id
  direction     = "INGRESS"
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["mcserver"]
  priority      = 1000
}
# ALLOW HTTP
resource "google_compute_firewall" "http" {
  name = "allow-http"

  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["http-server"]
}

# ALLOW HTTPS
resource "google_compute_firewall" "https" {
  name = "allow-https"

  allow {
    ports    = ["443"]
    protocol = "tcp"
  }

  direction     = "INGRESS"
  network       = google_compute_network.vpc_network.id
  priority      = 1000
  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["https-server"]
}

resource "google_compute_firewall" "mcmanager" {
  name = "allow-mcmanager"

  allow {
    ports    = ["7777"]
    protocol = "tcp"
  }
  
  network       = google_compute_network.vpc_network.id
  direction     = "INGRESS"
  source_ranges = ["10.0.0.0/24"]
  target_tags   = ["mcmanager"]
  priority      = 1000
}