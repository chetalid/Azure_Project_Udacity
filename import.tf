resource "azurerm_resource_group" "main" {
   name     = "Azuredevops"
   location = var.location

   tags = {
    "tagName" = "webserver"
  }
}