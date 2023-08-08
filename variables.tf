variable "credential_file" {}
variable "project" {}
variable "region" {}
variable "zone" {}
variable "sshkey_server" {}
variable "privkey_ansible"{}
variable "cloudflare_api_token" {
    type = string
    sensitive = true
}
variable "cloudflare_zone_id" {
    type = string
    sensitive = true
}
variable "domain_name" {
    type = string
    sensitive = true
}