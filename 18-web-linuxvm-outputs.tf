# Public IP Outputs
/*
## Public IP Address
output "web_linuxvm_public_ip" {
  description = "Web Linux VM Public Address"
  value = azurerm_public_ip.web_linuxvm_publicip.ip_address
}
*/

# Network Interface Outputs
## Network Interface id
output "web_linuxvm_nic_id" {
  value = azurerm_network_interface.web_linuxvm_nic.id
}

## Network Interface Private Ip Addess
output "web_linuxvm_interface_private_ip_address" {
  value = azurerm_network_interface.web_linuxvm_nic.private_ip_address
}

# Linux VM Outputs
/*
## Virtual Machine Public IP
output "web_linuxvm_public_ip_address" {
  description = "Web Linux Virtual Machine Public IP"
  value = azurerm_linux_virtual_machine.web_linuxvm.public_ip_address
}
*/

# Virtual Machine Private Ip
output "web_linuxvm_private_ip_address" {
  value = azurerm_linux_virtual_machine.web_linuxvm.private_ip_address
}

## Virtual Machine 128-bit Id
output "web_linuxvm_machine_id_128bit" {
  value = azurerm_linux_virtual_machine.web_linuxvm.virtual_machine_id
}

## Virtual Machine Id
output "web_linuxvm_machine_id" {
  value = azurerm_linux_virtual_machine.web_linuxvm.id
}