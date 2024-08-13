# Resource : Create Bastion / Management Subnet
resource "azurerm_subnet" "bastionsubnet" {
  name = "${local.resource_name_prefix}-${var.bastion_subnet}"
  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes = var.bastion_subnet_address_space
}

# Resource : Create Network Security Group 
resource "azurerm_network_security_group" "bastion_subnet_nsg" {
  name = "${azurerm_subnet.bastionsubnet.name}-nsg"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
}

# Resource : Assocaite Network Security Group and Subnet
resource "azurerm_subnet_network_security_group_association" "bastion_subnet_nsg_associate" {
  depends_on = [ azurerm_network_security_rule.bastion_nsg_rule_inbound ]
  subnet_id = azurerm_subnet.bastionsubnet.id
  network_security_group_id = azurerm_network_security_group.bastion_subnet_nsg.id
}
# Create Local blocks for Security rules
locals {
  bastion_inbound_ports_map = {
    "100" : "22",
    "110" : "3389"
  }
}
# Resource : Cereate Network Security Rule
resource "azurerm_network_security_rule" "bastion_nsg_rule_inbound" {
  for_each = local.bastion_inbound_ports_map
  name = "Rule-Port-${each.value}"
  priority = each.key
  protocol = "Tcp"
  direction = "Inbound"
  access = "Allow"
  source_port_range = "*"
  destination_port_range = each.value
  source_address_prefix = "*"
  destination_address_prefix = "*"
  resource_group_name = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.bastion_subnet_nsg.name
}