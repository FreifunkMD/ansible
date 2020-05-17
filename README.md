# FFMD Ansible

This repository is containing the ansible configuration used by "Freifunk Magdeburg" to setup our server infrastructure.

State: WIP / early development - **DO NOT EXECUTE, DUDE !!**

## Ansible Vault

### Create Vault Password File

Before using ansible-vault, we have to create a password-file:

``` bash
make vault-passwd
```

This will create a password file named `.vault.passwd`


### Creating Secrets

Secrets can be created using the ansible-vault command:
``` bash
ansible-vault encrypt_string --vault-password-file .vault.passwd 'foobar' --name 'the_secret'
```

The output is in yaml format & can be included in any ansible yaml-file.

## Requirements

Supported OS: Debian 10
Tested Ansible Version: 2.9


## Playbooks

### Gateways

Freifunk gateway configuration.

### Webserver

Webserver configuration

## Roles
### common

Common configuration & software installation for all servers.

### ssh

Configures the openssh-server. 

### users

Pulls Admin-SSH-Keys from Git and creates corresponding users.

### gateways

Deployes docker-compose-file, pulls the latest images & starts all containerized services.

### docker

Installes docker/-compose.
