resource "google_compute_address" "mcserver" {
  name   = "mcserver-static-ip"
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

}

resource "null_resource" "wait_for_instance" {
    provisioner "local-exec" {
    # interpreter = ["/bin/bash"]
    command = <<-EOT
      sleep 3m
      ssh-keyscan -H ${google_compute_address.mcserver.address} >> ~/.ssh/known_hosts
      ansible-playbook -i ${google_compute_address.mcserver.address}, --private-key ${var.privkey_ansible} ansible/setup_mcserver.yaml
    EOT
  }
  #   timeouts {
  #   create = "20m"
  #   update = "2h"
  #   delete = "20m"
  # }
  depends_on = [google_compute_instance.mcserver]
}