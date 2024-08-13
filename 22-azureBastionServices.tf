# Azure Bastion Service - Resources
## Resource 1 : Azure Bastion Subnet
resource "azurerm_subnet" "bastion_service_subnet" {
  name                  = "AzureBastionSubnet"
  resource_group_name   = azurerm_resource_group.rg.name
  virtual_network_name  = azurerm_virtual_network.vnet.name
  address_prefixes      = var.bastion_service_address_profixes
}

## Resource 2 : Azure Bastion Public Ip
resource "azurerm_public_ip" "bastion_service_publicip" {
  name                 = "${local.resource_name_prefix}-bastion-service-publicip"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  allocation_method    = "Static"
  sku                  = "Standard"
}

## Resource 3 : Azure Bastion  Host
resource "azurerm_bastion_host" "bastion_host" {
  name                = "${local.resource_name_prefix}-bastion-host"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  
  ip_configuration {
    name                        = "Configuration"
    subnet_id                   = azurerm_subnet.bastion_service_subnet.id
    public_ip_address_id        = azurerm_public_ip.bastion_service_publicip.id
  }
}