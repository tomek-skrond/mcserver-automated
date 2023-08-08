# mcserver-automated

<p float="left" align="center">
  <img style="width:25%;height:25%;" src="https://static-00.iconduck.com/assets.00/file-type-terraform-icon-455x512-csyun60o.png">
  <img style="width:35%;height:35%;" src="https://extremeautomation.io/static/9257437713a85f3e9e5cb6e7ff7bb507/ansible.svg">
</p>

### Description
IaC project that provisions infrastructure on Google Cloud:
- A Minecraft Server Management tool
- Systemd service (for server management tool)
- Nginx reverse proxy
- Domain registration for website (creating DNS records)

You can view code for the my server management tool (`docker-runner-api`) [this repo](https://github.com/tomek-skrond/docker-runner-api).

Provisioning is done using Terraform, after resources get provisioned, they are configured by Ansible.

All services have their domains/subdomains and certificats registered in Cloudflare.

### Prerequisites for Deployment
Before deploying, take actions to complete prerequisites as described below.

#### Prerequisite: .env file
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

#### Prerequisite: Package Dependencies
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

### Deployment

After completing `Prerequisites for Deployment`, source the `.env` file and the only commands you need are:
```
terraform plan
```
and
```
terraform apply
```

Enjoy!
