resource "azurerm_resource_group" "vnet_rg" {
  name     = var.resource_group_name
  location = var.location
  tags     = merge(local.common_tags, var.tags)
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.vnet_rg.name
  location            = azurerm_resource_group.vnet_rg.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = merge(local.common_tags, var.tags)
}

# Subnets
resource "azurerm_subnet" "subnets" {
  for_each = { for subnet in var.subnets : subnet.name => subnet }

  name                 = each.value.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [each.value.address_prefix]
  service_endpoints    = lookup(each.value, "service_endpoints", [])

  dynamic "delegation" {
    for_each = each.value.delegation != null ? [each.value.delegation] : []
    
    content {
      name = delegation.value.name
      
      service_delegation {
        name    = delegation.value.service_delegation_name
        actions = lookup(delegation.value, "service_delegation_actions", [])
      }
    }
  }
}

# Network Security Groups
resource "azurerm_network_security_group" "nsg" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if lookup(subnet, "create_nsg", true) }

  name                = "${each.value.name}-nsg"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  tags                = merge(local.service_tags, var.tags)
}

# NSG Association
resource "azurerm_subnet_network_security_group_association" "nsg_association" {
  for_each = { for subnet in var.subnets : subnet.name => subnet if lookup(subnet, "create_nsg", true) }

  subnet_id                 = azurerm_subnet.subnets[each.key].id
  network_security_group_id = azurerm_network_security_group.nsg[each.key].id
}

# NSG Rules
resource "azurerm_network_security_rule" "nsg_rules" {
  for_each = {
    for rule in local.nsg_rules : "${rule.subnet_name}-${rule.name}" => rule
  }

  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = each.value.source_port_range
  destination_port_range      = each.value.destination_port_range
  source_address_prefix       = each.value.source_address_prefix
  destination_address_prefix  = each.value.destination_address_prefix
  resource_group_name         = azurerm_resource_group.vnet_rg.name
  network_security_group_name = azurerm_network_security_group.nsg[each.value.subnet_name].name
}

# NSG rules from subnet configurations
locals {
  nsg_rules = flatten([
    for subnet_key, subnet in var.subnets : [
      for rule_key, rule in lookup(subnet, "nsg_rules", {}) : {
        subnet_name              = subnet.name
        name                     = rule_key
        priority                 = rule.priority
        direction                = lookup(rule, "direction", "Inbound")
        access                   = lookup(rule, "access", "Allow")
        protocol                 = lookup(rule, "protocol", "Tcp")
        source_port_range        = lookup(rule, "source_port_range", "*")
        destination_port_range   = lookup(rule, "destination_port_range", "*")
        source_address_prefix    = lookup(rule, "source_address_prefix", "*")
        destination_address_prefix = lookup(rule, "destination_address_prefix", "*")
      }
    ] if lookup(subnet, "create_nsg", true)
  ])
}


# Public IP for NAT Gateway
resource "azurerm_public_ip" "nat_gateway_ip" {
  count               = var.create_nat_gateway ? 1 : 0
  
  name                = "${var.vnet_name}-natgw-ip"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = merge(local.service_tags, var.tags)
}

# NAT Gateway
resource "azurerm_nat_gateway" "nat_gateway" {
  count               = var.create_nat_gateway ? 1 : 0
  
  name                = "${var.vnet_name}-natgw"
  location            = azurerm_resource_group.vnet_rg.location
  resource_group_name = azurerm_resource_group.vnet_rg.name
  sku_name            = "Standard"
  tags                = merge(local.service_tags, var.tags)
}

# Associating Public IP with NAT Gateway
resource "azurerm_nat_gateway_public_ip_association" "nat_gateway_ip_association" {
  count                = var.create_nat_gateway ? 1 : 0
  
  nat_gateway_id       = azurerm_nat_gateway.nat_gateway[0].id
  public_ip_address_id = azurerm_public_ip.nat_gateway_ip[0].id
}

# NAT Gateway Subnet Association
resource "azurerm_subnet_nat_gateway_association" "nat_gateway_subnet_association" {
  for_each = var.create_nat_gateway ? { for subnet_name in var.nat_gateway_subnet_names : subnet_name => subnet_name } : {}
  
  subnet_id      = azurerm_subnet.subnets[each.key].id
  nat_gateway_id = azurerm_nat_gateway.nat_gateway[0].id
}