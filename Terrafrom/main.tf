provider "azurerm" {
    use_oidc = true
    features{

    }
}

terraform {
  backend "azurerm" {
    resource_group_name  = "tf-rg-dev-terraform-westus-0001"
    storage_account_name = "tfstdevtfstatewus01"
    container_name       = "tfstate-edial-outbound"
    key                  = "edial-outbound-dev/dev_terraform.tfstate"
    use_oidc = true
  }
  required_version = ">= 1.6.0, <= 2.0.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.72.0"
    }
      azapi = {
      version = "~> 1.4.0"
      source  = "Azure/azapi"
    }
  }
}

