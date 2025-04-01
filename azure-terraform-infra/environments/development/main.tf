terraform {
  required_version = "= 1.10.2"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }

 backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "opellatfstates"
    container_name       = "tfstate"
    key                  = "dev/terraform.tfstate"
  }

}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}
# Creating opella-dev-vnet using module
module "opella-dev-vnet" {
  source = "../../modules/opella-dev-vnet"

  resource_group_name      = var.resource_group_name
  location                 = var.location
  vnet_name                = var.vnet_name
  address_space            = var.address_space
  dns_servers              = var.dns_servers
  subnets                  = var.subnets
  tags                     = var.tags
  create_nat_gateway       = var.create_nat_gateway
  nat_gateway_subnet_names = var.nat_gateway_subnet_names
}

# Creating opella-dev-vms using compute module

module "compute" {
  source = "../../modules/compute"
  
  # General
  resource_group_name = var.resource_group_name
  location            = var.location
  
  # Opella Web VM
  web_vm_name          = var.web_vm_name
  web_subnet_id        = module.opella-dev-vnet.subnet_ids["web-subnet"]
  web_vm_size          = var.web_vm_size
  web_admin_username   = var.admin_username
  web_admin_ssh_key    = var.admin_ssh_key
  web_vm_public_ip     = var.web_vm_public_ip
  
  # Opella dev App VM
  app_vm_name          = var.app_vm_name
  app_subnet_id        = module.opella-dev-vnet.subnet_ids["app-subnet"]
  app_vm_size          = var.app_vm_size
  app_admin_username   = var.admin_username
  app_admin_ssh_key    = var.admin_ssh_key
  app_vm_public_ip     = var.app_vm_public_ip
  
  # Common
  os_image                      = var.os_image
  tags                          = var.tags
  boot_diagnostics_storage_account = var.boot_diagnostics_storage_account
  
  depends_on = [module.opella-dev-vnet]
}