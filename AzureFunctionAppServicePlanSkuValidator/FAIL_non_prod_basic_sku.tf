# ============================================================
# FAIL_non_prod_basic_sku.tf
#
# Policy   : AzureFunctionAppServicePlanSkuValidator
# Scenario : Non-prod environment + Basic SKU (B1)
# Expected : FAIL — prefix "b" matches DEDICATED_SKU_PREFIXES
#
# Execution trace:
#   1. is_non_prod_environment()
#      → get_environment_from_tags() → "environment" = "dev"
#      → NON_PROD_VALUE_PATTERN.match("dev") → True
#      → Guard 1 passes through (no continue)
#   2. dereference(config, "sku_name", default="") → "B1"
#      "b1".startswith(("b","s","p"))             → True  [prefix "b"]
#      → self.details.append("B1")
#      → set_status_and_construct_output(block_file_findings) returned
#
# Default output message:
#   "Dedicated App Service Plan SKU is not permitted in Dev/Test environments.
#    Switch to Consumption (Y1), Elastic Premium (EP1/EP2/EP3), or Flex Consumption (FC1)."
#
# DEDICATED_SKU_PREFIXES prefix exercised: "b" (Basic tier — B1, B2, B3)
# ============================================================

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
}

# ---------------------------------------------------------------------------
# Supporting resource — resource group
# ---------------------------------------------------------------------------
resource "azurerm_resource_group" "fail_basic_rg" {
  name     = "rg-serviceplan-fail-basic"
  location = "East US"
}

# ---------------------------------------------------------------------------
# Primary resource under test
# ---------------------------------------------------------------------------
resource "azurerm_service_plan" "fail_basic_plan" {
  name                = "asp-fail-basic-dev"
  resource_group_name = azurerm_resource_group.fail_basic_rg.name
  location            = azurerm_resource_group.fail_basic_rg.location
  os_type             = "Linux"

  sku_name = "B1" # ❌ FAIL: "b1".startswith(("b","s","p")) → True (prefix "b" — Basic tier)
                  #          → self.details.append("B1")
                  #          → set_status_and_construct_output() called

  tags = {
    environment = "dev" # ✅ Passes Guard 1 — NON_PROD_VALUE_PATTERN.match("dev") → True
                        #   proceeds to SKU check
  }
}
