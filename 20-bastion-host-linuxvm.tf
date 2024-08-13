## Bastion Linuxvm Resources
# Resource : Create Bastion Host Public IP address
resource "azurerm_public_ip" "bastion_host_publicip" {
  name                  = "${local.resource_name_prefix}-bastion-host-publicip"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  allocation_method     = "Static"
  sku                   = "Standard"
}

# Resource : Create Network Interface
resource "azurerm_network_interface" "bastion_linuxvm_nic" {
  name = "${local.resource_name_prefix}-bastion-linuxvm-nic"
  resource_group_name = azurerm_resource_group.rg.name
  location = azurerm_resource_group.rg.location
  ip_configuration {
    name                          = "bastion-host-ip-1"
    subnet_id                     = azurerm_subnet.bastionsubnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_publicip.id
  }
}

# Resource : Azure Linux Virtual Machine - Bastion Host
resource "azurerm_linux_virtual_machine" "bastion_host_linuxvm" {
  name                  = "${local.resource_name_prefix}-bastion-linuxvm"
  resource_group_name   = azurerm_resource_group.rg.name
  location              = azurerm_resource_group.rg.location
  size                  = "Standard_DC8s_v3"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_linuxvm_nic.id]

  admin_ssh_key {
    username = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pem.pub")
  }
  os_disk {
    caching = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "RedHat"
    offer = "RHEL"
    version = "latest"
    sku = "83-gen2"
  }
}