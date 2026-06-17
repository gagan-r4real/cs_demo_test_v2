variable "project_name" {
    type        = string
    description = "Defines the name of the project."
}

variable "environment" {
    type        = string
    description = "Specifies the environment for which resources will be deployed (e.g., dev, test, prod)."
}

variable "location" {
    type        = string
    description = "Denotes the location/region where the Azure resource will be established."
}

variable "location_short" {
    type        = string
    description = "Specifies the shortened version of a location name."
}

variable "instance" {
    type        = string
    description = "Specifies the instance number to be created."
}

variable "instance_short" {
    type        = string
    description = "Short version of instance number to be created."
}

variable "resource_group_name" {
    type        = string
    description = "Specifies the name of the resource group where the resources will be deployed."
}

variable "tags" {
    type        = map(any)
    description = "Specifies a map of tags to be assigned to the created resources. Default tags will be applied if not overridden."
}

variable "app_service_plan" {
    type        = string
    description = "Specifies the name of the App Service Plan"
}

variable "asp_worker_count" {
    type = number
    description = "Specifies the count of the asp worker instance"

}

variable "app_service" {
    type        = string
    description = "Specifies the name of the Azure App Service"
}

variable "app_insights" {
    type        = string
    description = "Specifies the name of the Application Insights resource."
}

variable "log_analytics" {
    type        = string
    description = "Specifies the name of the Log Analytics workspace."
}

variable "eventhubnamespace" {
    type        = string
    description = "Specifies the name of the Event Hub Namespace."

}

variable "eventhubname_csv" {
    type        = string
    description = "Specifies the name of the Event Hub."
}

variable "eventhubroles" {
    type        = list(string)
    description = "Specifies the roles to be assigned to the Event Hub Namespace."
}

variable "redis_cache_name" {
  type        = string
  description = "Specifies the name of the Azure Redis Cache."
}

variable "storage_acc" {
    type = string
    description = "Specifies the name of the Storage Account."
    }

variable "storage_account_role_assignments" {
    type        = list(object({
    principal_id = list(string)
    role_name    = string
  }))
    description = "Specify the list of all Storage Account role assignments (e.g., Storage Blob Data Contributor, Storage Table Data Contributor)."
}

variable "storage_con" {
    type        = list(string)
    description = "Storage Account Container Name"
}

variable "eventhub_role_assigments_service_principal" {
    type = list(object({
        principal_id = list(string)
        role_name    = string
    }))
    description = "Specify the list of all Event Hub role assignments (e.g., Azure Event Hubs Data Owner, Azure Event Hubs Data Sender, Azure Event Hubs Data Receiver)."
}


variable "eventhubname_dataentity" {
    type        = string
    description = "Specifies the name of the Event Hub for data entity."

}

variable "eventhubcsvconsumergroups" {
    type        = list(string)
    description = "Specifies the consumer groups for the Event Hub CSV."

}

variable "eventhubdataentityconsumergroups" {
    type        = list(string)
    description = "Specifies the consumer groups for the Event Hub data entity."

}

variable "resource_group_role_assignments" {
    type        = list(object({
    principal_id = list(string)
    role_name    = string
  }))
    description = "Specify the list of all Resource Group role assignments (Contributor, Reader, custom roles)."


}

variable "Aspdotnet_core_env" {
    type        = string
    description = "Specifies the environment for Aspdotnet core."

}


variable "Manged_grafana" {
    type        = string
    description = "Specifies the name of the Managed Grafana resource."

}
variable "grafana_role_assignments" {
  type = list(object({
    principal_id = list(string)
    role_name    = string
  }))
  description = "Specifies the role assignments for Grafana."
}

variable "Subscription_ID" {
    type        = string
    description = "Specifies the Subscription ID for the Azure resources."
}



variable "key_vault" {
  type        = string
  description = "Specifies the name of the Azure Key Vault."
}

variable "project_name_short" {
  type        = string
  description = "Specifies the shortened version of a project name."
}

variable "keyvault_access_policy_vendor_list" {
  type        = list(string)
  description = "A list of access policies for vendors to access the Key Vault."
}

variable "eventhub_namespace_capacity" {
  type        = number
  description = "Specifies the capacity of the Event Hub Namespace."

}

variable "eventhub_fdrbatchstatus" {
    type        = string
    description = "Specify the Status Eventhub Name."
}

variable "eventhubfdrconsumergroups" {
    type        = list(string)
    description = "Specifies the consumer groups for the Event Hub FDR Batch Status."
}

variable "container_registry_name" {
  type        = string
  description = "Specify the container registry name"
}

variable "container_app_environment_name" {
  type        = string
  description = "Specify the container app environment name"
}

variable "container_app_name" {
  type        = string
  description = "Specify the container app name."
}

variable "container_app_image_tag" {
  type        = string
  description = "Specify the container app existing image tag number."
}

variable "monitor_action_group_name" {
    type        = string
    description = "Specify the container app monitor alert group name."
}

variable "monitor_action_group_short_name" {
    type        = string
    description = "Specify the container app monitor alert group short name."
}

variable "monitor_alert_email_receivers" {
    type = list(object({
      receiver_name    = string
      receiver_mail_id = string
    }))

}

variable "monitor_alert_name" {
    type        = string
    description = "Specify the container app monitor alert name."
}

variable "container_app_environment" {
    type        = string
    description = "Specify the container app environment type like 'dev', 'test', 'prod' etc."
}

variable "feature_flag" {
   type = object({
    EnableDeltaEvents = string
  })
}

variable "storage_account_role_assignments_serviceprincipal" {
    type        = list(object({
    principal_id = list(string)
    role_name    = string
  }))
    description = "Specify the list of all Storage Account role assignments (e.g., Storage Blob Data Contributor, Storage Table Data Contributor)."

}

variable "app_service_feature_flags" {
    type = object({
      FullLoadRegions   = string
      EnabledRegions    = string
      EnableDR          = bool
    })
    description = "Specify the list of feature flag/env varaible values for api app service."

}

variable "redis_cache_location" {
    type        = string
    description = "Specify the dr redis cache location."
}

variable "amr_name" {
    type        = string
    description = "Specify the azure managed redis cache location."
}