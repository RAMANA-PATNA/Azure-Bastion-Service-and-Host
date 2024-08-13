# Vnet input variables
variable "vnet_name" {
  type = string
}
# Vnet address space
variable "vnet_address_space" {
  type = list(string)
}

# Web subnet
variable "web_subnet" {
  type = string
}

# Web subnet address space
variable "web_subnet_address_space" {
  type = list(string)
}

# App subnet
variable "app_subnet" {
  type = string
}

# App subnet address space
variable "app_subnet_address_space" {
  type = list(string)
}

# Data Base subnet
variable "db_subnet" {
  type = string
}

# Data Base subnet address space
variable "db_subnet_address_space" {
  type = list(string)
}

# Bastion / Management subnet
variable "bastion_subnet" {
  type = string
}

# Bastion / Management subnet address space
variable "bastion_subnet_address_space" {
  type = list(string)
}