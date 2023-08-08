terraform {
  required_version = ">= 0.12"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

provider "google" {
  credentials = file(var.credential_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

provider "cloudflare" {
  api_token = var.cloudflare_api_token
}