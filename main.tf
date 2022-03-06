provider "azurerm" {
  version = "~>2.63"
  features {
    # key_vault {
    #   purge_soft_delete_on_destroy = true
    # }
  }
}

terraform {
  required_version = ">= 0.12.6"
  backend "azurerm" {
    resource_group_name  = "azcontainerapp-rg"
    storage_account_name = "azcontainerappstorage"
    container_name       = "tfstate"
    key                  = "test.terraform.state"
  }
}