###########################################################
# Azure App Services
###########################################################
# resource "azurerm_resource_group" "tf-rg" {
#   name     = "azcontainerapp-rg"
#   location = var.az_region
# }
data "azurerm_resource_group" "tf-rg" {
  name = "azcontainerapp-rg"
}

resource "azurerm_app_service_plan" "tf_app_service_plan" {
  name                = "${var.app_name}-app-service-plan"
  location            = data.azurerm_resource_group.tf-rg.location
  resource_group_name = data.azurerm_resource_group.tf-rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "tf_app_service" {
  name                = "${var.app_name}-service"
  location            = data.azurerm_resource_group.tf-rg.location
  resource_group_name = data.azurerm_resource_group.tf-rg.name
  app_service_plan_id = azurerm_app_service_plan.tf_app_service_plan.id

  app_settings = {
    DOCKER_REGISTRY_SERVER_URL      = "azacr1202.azurecr.io"
    DOCKER_REGISTRY_SERVER_USERNAME = "azacr1202"
    DOCKER_REGISTRY_SERVER_PASSWORD = "@Microsoft.KeyVault(SecretUri=${azurerm_key_vault_secret.keyvault_secret.versionless_id})"
  }
  site_config {
    linux_fx_version = "DOCKER|azacr1202.azurecr.io/azcontainerapp:latest"
  }

  tags = {
    Name        = "${var.app_name}-app-service"
    Environment = var.app_environment
  }

}