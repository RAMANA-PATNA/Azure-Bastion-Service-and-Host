# Resource : Web Tier subnet
resource "azurerm_subnet" "websubnet" {
  name                  =  "${local.resource_name_prefix}-${var.web_subnet}"
  resource_group_name   =  azurerm_resource_group.rg.name
  virtual_network_name  =  azurerm_virtual_network.vnet.name
  address_prefixes      =  var.web_subnet_address_space
}

# Resource : Create Network Security Group
resource "azurerm_network_security_group" "web_subnet_nsg" {
  name                 =  "${azurerm_subnet.websubnet.name}-nsg"
  resource_group_name  =  azurerm_resource_group.rg.name
  location             =  azurerm_resource_group.rg.location
}

#Resource : Associate Network Security Group and subnet
resource "azurerm_subnet_network_security_group_association" "web_subnet_nsg_associate" {
    # Evey NSG Rule association will be disassociate NSG from subnet and associate it, so we assocaite it only after NSG is completely created
    depends_on = [ azurerm_network_security_rule.web_nsg_rule_inbound ]
    subnet_id = azurerm_subnet.websubnet.id
    network_security_group_id = azurerm_network_security_group.web_subnet_nsg.id
}

# Resource 4 : Create network Security Group Rule
## Create Local blocks for security rules
locals {
  web_inbound_ports_map = {
    "100" : "80", # If the key map is number then use colon insted of "="
    "110" : "443",
    "120" : "22"
    }
}

# Resource: Create NSG Rule
resource "azurerm_network_security_rule" "web_nsg_rule_inbound" {
  for_each = local.web_inbound_ports_map
  name                          =  "Rule-Port-${each.value}"
  priority                      =  each.key
  direction                     =  "Inbound"
  access                        =  "Allow"
  protocol                      =  "Tcp"
  source_port_range             =  "*"
  destination_port_range        =  each.value
  source_address_prefix         =  "*"
  destination_address_prefix    =  "*"
  resource_group_name           =  azurerm_resource_group.rg.name
  network_security_group_name   =  azurerm_network_security_group.web_subnet_nsg.name
}