# Resource : Create Resource Group
resource "azurerm_resource_group" "rg" {
  name = "${local.resource_name_prefix}-${var.azurerm_resource_group}-${random_string.myrandom.id}"
  location = var.azurerm_resource_group_location
  tags = local.common_tags
}