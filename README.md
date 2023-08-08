# mcserver-automated

IaC that provisions Google Cloud infrastructure:
- A Minecraft Server Management tool
- Systemd service (for server management tool)
- Nginx reverse proxy
- Domain registration for website (creating DNS records)

You can view code for the my server management tool (`docker-runner-api`) [this repo](https://github.com/tomek-skrond/docker-runner-api).

Provisioning is done using Terraform, after resources get provisioned, they are configured by Ansible.

All services have their domains/subdomains and certificats registered in Cloudflare.

To successfully deploy this project, you need your own `.env` file that covers all needed environmental variables for Terraform.

Example `.env` file:

```
export TF_VAR_credential_file=/path/to/file
export TF_VAR_project=projectname
export TF_VAR_region=your_region         #(example: europe-west)
export TF_VAR_zone=your_zone             #(example: europe-west1-b)
export TF_VAR_sshkey_server=/path/to/pubkey
export TF_VAR_privkey_ansible=/path/to/privkey
export TF_VAR_cloudflare_api_token=<cloudflare token>
export TF_VAR_cloudflare_zone_id=<cloudflare zone ID>
export TF_VAR_domain_name="your_domain_name.com"
```

### Dependencies
Dependencies to install are:
- terraform
- ansible
- nmap

```
$ terraform -version
Terraform v1.5.3
on linux_amd64
```

```
$ ansible --version
ansible [core 2.15.2]
```

```
$ nmap --version
Nmap version 7.94 ( https://nmap.org )
Platform: x86_64-pc-linux-gnu
Compiled with: liblua-5.4.6 openssl-3.1.1 libssh2-1.10.0 libz-1.2.13 libpcre-8.45 libpcap-1.10.4 nmap-libdnet-1.12 ipv6
Compiled without:
Available nsock engines: epoll poll select
```
