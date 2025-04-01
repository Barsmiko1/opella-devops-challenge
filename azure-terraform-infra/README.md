# opella-devops-challenge

# Azure Infrastructure with Terraform

## Overview

This repository contains Terraform code for deploying modular, reusable Azure infrastructure, following Infrastructure as Code (IaC) best practices. The solution focuses on creating a flexible VNET architecture that can be used across multiple environments.

## Project Structure

azure-terraform-infra/
│
├── modules/
│   ├── opella-dev-vnet/ 
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── opella-dev-vnet.tf
│   │
│   ├── compute/          
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   └── README.md
│   │
│   └── storage/             
│       ├── main.tf
│       ├── variables.tf
│       ├── outputs.tf
│       └── README.md
│
├── environments/
│   ├── development/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── dev.tfvars
│   │   └── outputs.tf
│   │
│   └── production/
│       ├── main.tf
│       ├── variables.tf
│       ├── prod.tfvars
│       └── outputs.tf
│
├── .github/
│   └── workflows/
│       └── terraform-pipeline.yml
│
├── .gitignore
└── README.md

## Modules

### opella-dev-vnet Module

Creates a complete networking setup with:
- Virtual Network with customizable address space
- Multiple subnets with security groups
- Network security rules based on best practices
- Service endpoints for secure Azure service access

### Compute Module

Creates virtual machines with:
- Linux or Windows operating systems
- Public or private networking
- Boot diagnostics and monitoring
- Security group integration

### Storage Module

Creates storage resources with:
- Customizable storage account configurations
- Blob containers with appropriate access levels
- Network rules for secure access

## Getting Started

### Prerequisites

- Terraform >= 1.0.0
- Azure CLI >= 2.30.0
- An Azure subscription

### Initial Setup

1. Clone the repository:
   
   git clone https://github.com/Barsmiko1/opella-devops-challenge.git
   cd azure-terraform-infra


2. Authenticate to Azure:

   az login


3. Initialize Terraform for the development environment:

   cd environments/dev
   terraform init


4. Review and update the terraform.tfvars file with your configuration

5. Apply the Terraform configuration:

   terraform plan -out=tfplan
   terraform apply tfplan

## Best Practices Implemented

1. Modularity: Reusable modules with standard interfaces
2. Security by Default: NSGs, private subnets, limited public exposure
3. Multi-Environment Support: Development and production with consistent configuration
4. Tagging Strategy: All resources tagged for management and cost tracking
5. Clean Code: Consistent formatting and documentation

## CI/CD Integration

The repository includes a GitHub Actions workflow for:
- Validating Terraform code
- Creating execution plans
- Applying changes after approval
- Providing plan outputs as comments on pull requests

To use it, configure the appropriate GitHub secrets for Azure authentication.

## Security Considerations

- Network traffic is restricted with NSGs
- VMs are deployed in private subnets where possible
- Access to storage is limited to authorized networks
- Secrets management through variables (not stored in code)