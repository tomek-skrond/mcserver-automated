resource "google_compute_address" "mcserver" {
  name   = "mcserver-static-ip"
  region = var.region
}

resource "google_compute_address" "elkstack" {
  name   = "elstack-static-ip"
  region = var.region
}

resource "google_compute_address" "lb" {
  name   = "lb-static-ip"
  region = var.region
}


resource "google_compute_instance" "mcserver" {
  metadata = {
    "ssh-keys" = <<EOT
            admin:${file(var.sshkey_server)}
        EOT
  }

  name         = "server"
  machine_type = "e2-standard-2"
  zone         = var.zone
  tags         = ["http-server","https-server","ssh", "mcserver","mcmanager"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = google_compute_network.vpc_network.id
    subnetwork = google_compute_subnetwork.server.id
    access_config {
        nat_ip = google_compute_address.mcserver.address
    }
  }

  provisioner "local-exec" {
    command = <<-EOT
    while [ 1 ]; do
      if [ "$(nmap -Pn -p22 ${google_compute_instance.mcserver.network_interface.0.access_config.0.nat_ip} | head -n -2 | tail -n +6 | awk '{print $2}')" == "open" ]; then
        echo "OPEN"
          ssh-keyscan -H ${google_compute_instance.mcserver.network_interface.0.access_config.0.nat_ip} >> ~/.ssh/known_hosts
          ansible-playbook -i ${google_compute_instance.mcserver.network_interface.0.access_config.0.nat_ip}, --private-key ${var.privkey_ansible} ansible/setup_mcserver.yaml
          break
          exit 0
      else
        echo "NOT OPEN"
        sleep 2
      fi
    done
    EOT
  }
    timeouts {
    create = "20m"
    update = "2h"
    delete = "20m"
  }
}