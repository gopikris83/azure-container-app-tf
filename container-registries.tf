###########################################################
# Azure Container Registry
###########################################################
resource "azurerm_container_registry" "tf-acr" {
  name                = "azacr1202"
  resource_group_name = azurerm_resource_group.tf-rg.name
  location            = azurerm_resource_group.tf-rg.location
  sku                 = "Standard"
  admin_enabled       = true
}