# Bastion Linux VM Input variables place holder file
variable "bastion_service_subnet_name" {
  description = "Bastion Service Subnet name"
  default = "AzureBastionSubnet"
}

variable "bastion_service_address_profixes" {
  description = "Bastion Service Address Profixes"
  default = ["10.0.100.0/26"]
}