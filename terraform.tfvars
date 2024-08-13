business_devision                =  "hr"
envirnoment                      =  "dev"
azurerm_resource_group           =  "rg"
azurerm_resource_group_location  =  "eastus"

vnet_name                        =  "vnet"
vnet_address_space               =  ["10.1.0.0/16"]

web_subnet                       =  "websubnet"
web_subnet_address_space         =  ["10.1.1.0/24"]

app_subnet                       =  "appsubnet"
app_subnet_address_space         =  ["10.1.11.0/24"]

db_subnet                        =  "dbsubnet"
db_subnet_address_space          =  ["10.1.24.0/24"]

bastion_subnet                   =  "bastionsubnet"
bastion_subnet_address_space     =  ["10.1.100.0/24"]

bastion_service_subnet_name             = "AzureBastionsubnet"
bastion_service_address_profixes = ["10.1.101.0/26"]
