# Azure App Service Provisioning - Terraform

Simple Azure App service used for provisioning containerized app deployment using Terraform. 

There is also Azure Key vault is provisioned for handling the secrets.

For more details on Terraform : https://www.terraform.io/


![Azure-Container-App-Service](/Az-app-service.png)


## What is deployed ?

Things that are deployed as part of [Terraform] :

Application container deployed to print User-Agent Info

* Azure App Service
* Azure Key Vault
* Azure Container Registry - For docker images storage
* Azure Storage account with container - for storing the terraform state file

### Install dependencies

* [`Python`](https://www.python.org/downloads/) Refer the link
* [`Docker`](https://docs.docker.com/engine/install/) Refer the link
* [`Make`](https://www.gnu.org/software/make/) Refer the link. Make for running container build and test on local machine
* [`terraform`](https://learn.hashicorp.com/tutorials/terraform/install-cli) required for `terraform deploy`.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.1.0 |

## Providers

| Name | Version |
|------|---------|
| azure | ~>2.63 |

## Usage

1. Use below backend script to create resource group and storage backend for storing state file
```
Use Make file commands to execute
$ make run-remote-backend

```
2. Build docker images and push to Azure ACR. Make sure the ACR credentials are added in Key vault Secrets for App services to authenticate and pull images.

```
$ make run-build
$ make run-push


Use Az Login with Service Principal for Azure login. 

Use docker login loginServer(Azure container registry) -u Username and -p Password

SET below credentials for pulling the docker images form ACR

DOCKER_REGISTRY_SERVER_URL
DOCKER_REGISTRY_SERVER_USERNAME
DOCKER_REGISTRY_SERVER_PASSWORD


```

Use the app services endpoint to access the docker container app.

In order to do deploy or do changes to the infrastructure you must:

* Init/Plan/Apply

### Init, Plan and Apply changes using Targets
```
# Run terraform to initialize, plan (preview the infrastructure) and apply for provisioning.

terraform init

terraform plan

terraform apply -target=<resource>

# Finally, destroy all infrastructure using terraform destroy

terraform destroy -target=<resource>
```

Alternatively, make file can be used to provision and destroy terraform plan.
```
$ make run-plan

$ make run-apply

$ make run-destroy

```





