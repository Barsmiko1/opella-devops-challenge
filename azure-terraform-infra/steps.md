# Setting Up and Deploying Azure Infrastructure with Terraform

This document outlines the step-by-step process to set up and deploy the Azure infrastructure using Terraform modules.

## Prerequisites

- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli) installed
- [Terraform](https://www.terraform.io/downloads.html) (v1.0.0 or newer) installed
- An active Azure subscription
- Git installed (for version control)

## 1. Repository Setup

1. Create a new repository:
   mkdir azure-terraform-infra
   cd azure-terraform-infra
   git init

2. Create the folder structure:
   mkdir -p modules/opella-dev-vnet
   mkdir -p modules/compute
   mkdir -p modules/storage
   mkdir -p environments/development
   mkdir -p environments/production
   mkdir -p .github/workflows

## 2. Module Development

### Networking Module

1. Create the main Terraform files:
   cd modules/opella-dev-vnet
   touch main.tf variables.tf outputs.tf README.md opella-dev-vnet.tf


2. Implement the network module as per the code provided in the module files.

3. Create a README file explaining the module's usage.

### Compute Module

1. Create the main Terraform files:
   cd ../compute
   touch main.tf variables.tf outputs.tf README.md opella-dev-vm-app.tf opella-dev-vm-web.tf


2. Implement the compute module as per the code provided in the module files.

3. Create a README file explaining the module's usage.

### Storage Module (Optional)

1. Create the main Terraform files:
   cd ../storage
   touch main.tf variables.tf outputs.tf README.md

2. Implement the storage module based on your requirements.

## 3. Environment Configuration

### Development Environment

1. Navigate to the dev environment directory:
  
   cd ../../environments/development


2. Create the necessary files:

   touch main.tf variables.tf outputs.tf terraform.tfvars


3. Implement the environment configuration using the modules:


### Production Environment

1. Set up similar files for the production environment with appropriate values.

## 4. GitHub Actions Workflow

1. Create the GitHub Actions workflow file:

   cd ../../.github/workflows/
   touch terraform.yml

2. Implement the GitHub Actions workflow as provided in the workflow file.

## 5. Initialize and Deploy

### Local Deployment

1. Authenticate to Azure:

   az login


2. Initialize Terraform in the dev environment:

   cd ../../environments/dev
   terraform init


3. Validate the configuration:

   terraform validate


4. Create an execution plan:

   terraform plan -out=tfplan


5. Review the plan and apply the changes:

   terraform apply tfplan

### GitHub Actions Deployment

1. Push your code to GitHub:
   git add .
   git commit -m "Initial infrastructure setup"
   git remote add origin https://github.com/your-username/azure-terraform-infra.git
   git push -u origin main

2. Set up the GitHub repository secrets:
   - Go to your repository's Settings > Secrets > New repository secret
   - Create a secret named `AZURE_CREDENTIALS` with your Azure service principal JSON

3. Trigger the workflow:
   - Create a pull request to see the plan
   - Merge to main to apply changes

## 6. Testing the Infrastructure

1. Verify that resources are created in Azure:

   az group list --query "[?contains(name, 'opella')].name" -o tsv


2. Check that the virtual network is created:
   az network vnet list --resource-group <resource-group-name> -o table

3. Verify the virtual machine is running:
   az vm list --resource-group <resource-group-name> -o table

## 7. Clean Up (When Needed)

To destroy the infrastructure and avoid unnecessary charges:

cd environments/development
terraform destroy

Confirm the destruction when prompted.

## Additional Resources

- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Azure Provider Documentation](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)