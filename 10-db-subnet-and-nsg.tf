# Resource : Cerate DataBase Subnet
resource "azurerm_subnet" "dbsubnet" {
  name = "${local.resource_name_prefix}-${var.db_subnet}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.db_subnet_address_space
}

# Resource Create Network Security Group
resource "azurerm_network_security_group" "db_subnet_nsg" {
  name = "${azurerm_subnet.dbsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

# Resource : Associate NSG and subnet
resource "azurerm_subnet_network_security_group_association" "db_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.db_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.dbsubnet.id
  network_security_group_id = azurerm_network_security_group.db_subnet_nsg.id
}

# Local blocks for Security Rules
locals {
  db_inbound_ports_map = {
    "100" : "3306",
    "110" : "1433",
    "120" : "5432"
  }
}

# Resource : Create Network Security Group (NSG)
resource "azurerm_network_security_rule" "db_nsg_rule_inbound" {
  for_each = local.db_inbound_ports_map
  name                          =  "Rule-Port-${each.value}"
  protocol                      =  "Tcp"
  direction                     =  "Inbound"
  priority                      =  each.key
  access                        =  "Allow"
  source_port_range             =  "*"
  destination_port_range        =  each.value
  source_address_prefix         =  "*"
  destination_address_prefix    =  "*"
  resource_group_name           =  azurerm_resource_group.rg.name
  network_security_group_name   =  azurerm_network_security_group.db_subnet_nsg.name
}