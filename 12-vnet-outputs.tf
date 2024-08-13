# Virtual Network Outputs
## Virtual Network Name
output "virtual_network_name" {
  value = azurerm_virtual_network.vnet.name
}

## Virtual Network Id
output "virtual_network_id" {
  value = azurerm_virtual_network.vnet.id
}

# Subnet Outputs (We will write for one web subnet and rest all ignore for now)
## Web Subnet outputs
output "web_dubnet_name" {
  value = azurerm_subnet.websubnet.name
}

## Web subnet id
output "web_subnet_id" {
  value = azurerm_subnet.websubnet.id
}

# Network Security Group Ouptus
## Web subnet nsg name
output "web_subnet_nsg_name" {
  value = azurerm_network_security_group.web_subnet_nsg.name
}

## Web subnet NSG id
output "web_subnet_nsg_id" {
  value = azurerm_network_security_group.web_subnet_nsg.id
}