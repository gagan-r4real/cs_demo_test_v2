#project details
project_name         = "edialoutbound"
environment          = "dev"
instance             = "0001"
instance_short       = "01"
Aspdotnet_core_env   = "Dev"

#resource group details
resource_group_name  = "tf-rg"
location             = "westus2"
location_short       = "wus2"
tags = {
    application     = "edialoutbound",
    environment     = "dev",
    deployment_type = "terraform"
}

#app service details
app_service_plan     = "tf-asp"
asp_worker_count     = 3
app_service          = "tf-app"
app_insights         = "tf-appi"
log_analytics        = "tf-log"
app_service_feature_flags = {
  FullLoadRegions   = ""
  EnabledRegions    = "TFRI"
  EnableDR          = false
}

#event hub details
eventhubnamespace         = "tf-evhns"
eventhubname_csv          = "tf-evh-adls-csv"
eventhubname_dataentity   = "tf-evh-dataentity"
eventhubroles             = ["Azure Event Hubs Data sender", "Azure Event Hubs Data receiver"]
eventhubcsvconsumergroups = ["edialoutboundservice-worker"]
eventhubdataentityconsumergroups = ["fdr-dataentity-checkpoint"]
eventhub_namespace_capacity      = 10

#redis cache detail
redis_cache_name     = "tf-redis"
redis_cache_location = "westcentralus"
amr_name             =  "tf-amr"


#storage account details
storage_acc = "tfstdevedialoutwus2"
storage_con = ["edialoutboundservice-singlton","edialoutboundservice-adls-csv-checkpoint","fdr-dataentity-checkpoint","fdr-batchstatus-checkpoint"]
storage_account_role_assignments = [
  {
    principal_id = ["7408d532-cb97-46f1-962e-524704c025c6", "5283f4b6-cd53-4e6c-851b-d54f9f31f416", "9c44e66a-f0a9-43cf-97b9-3cc736e7a867"]
    role_name    = "Storage Blob Data Contributor"
  },
  {
    principal_id = ["8e392649-cea8-4bb6-aa43-5bf0ecd558e7", "b04d7107-356a-4af3-b99d-6fe853b8a4d7"]
    role_name    = "Storage Blob Data Reader"
  }
]
storage_account_role_assignments_serviceprincipal = [
  {
    principal_id = ["9f4a2bbc-bff8-4e6f-a55b-de2d60fd2c31","a194995f-9e6e-4bfd-b0b4-2b59e3d45761","cbac8e42-fac8-4776-9ede-9e1fbabb40de","d24950b9-1e79-4434-aef8-e15995b9f692"]
    role_name    = "Storage Blob Data Contributor"
  }
]

eventhub_role_assigments_service_principal = [
  {
    principal_id = ["9f4a2bbc-bff8-4e6f-a55b-de2d60fd2c31","a194995f-9e6e-4bfd-b0b4-2b59e3d45761","cbac8e42-fac8-4776-9ede-9e1fbabb40de","d24950b9-1e79-4434-aef8-e15995b9f692"]
    role_name    = "Azure Event Hubs Data Receiver"
  }
]


# Grafana details
Manged_grafana     = "tf-grafana"
Subscription_ID    = "1bda16be-b774-4180-8ff1-44e47b94c9dd" #tffi-innovation-dev for role assiginment
grafana_role_assignments = [
  {
    principal_id = ["5283f4b6-cd53-4e6c-851b-d54f9f31f416"]
    role_name    = "Grafana Admin"
  },
  {
    principal_id = ["7408d532-cb97-46f1-962e-524704c025c6", "4b5ad3cf-55fc-494f-b419-1e4dbb7d01c7"] #grp_azr_vendor_appdev_dev_contributor #grp_azr_vendor_dataengineer_dev_contributor
    role_name    = "Grafana Editor"
  },
  {
    principal_id = ["8e392649-cea8-4bb6-aa43-5bf0ecd558e7", "b04d7107-356a-4af3-b99d-6fe853b8a4d7", "41630863-983a-4721-b410-4103f84f7d18"]
    role_name    = "Grafana Viewer"
  }
]

resource_group_role_assignments = [
  {
    principal_id = ["8e392649-cea8-4bb6-aa43-5bf0ecd558e7", "b04d7107-356a-4af3-b99d-6fe853b8a4d7", "41630863-983a-4721-b410-4103f84f7d18"] #grp_azr_vendor_appdev_dev_reader
    role_name    = "Reader"
  },
  {
    principal_id = ["7408d532-cb97-46f1-962e-524704c025c6", "5283f4b6-cd53-4e6c-851b-d54f9f31f416"] #grp_azr_vendor_appdev_dev_contributor #grp_azr_vendor_devops_dev_contributor
    role_name    = "Contributor"
  }
]

#Key Vault details
key_vault          = "tfkv"
project_name_short = "eob"
keyvault_access_policy_vendor_list = ["6a44d1cf-8cd7-478c-b339-21f7f6b62616","dce0f851-a718-47fa-a856-a13d1af4e542","95d4e3ed-75e9-44bf-b345-bf1db3846890"] #Pasupathikumar, #Nagaraju Bondala, #Harikrishna Mundra

# FDR Batch Status Event Hub Details
eventhub_fdrbatchstatus  = "tf-evh-batchstatus"
eventhubfdrconsumergroups = ["fdr-batchstatus-consumer"]

container_registry_name           = "tfcr"
container_app_environment_name    = "tf-cae"
container_app_name                = "tf-ca"
container_app_environment         = "Dev"
monitor_action_group_name         = "tf-ag"
monitor_action_group_short_name   = "tfag"
monitor_alert_name                = "tf-apr"
monitor_alert_email_receivers        = [
    {
        receiver_name    = "Pasupathikumar"
        receiver_mail_id = "ven_pkumar@taylorfarms.com"
    },
    {
        receiver_name    = "Mohammed Basharath Ahmed"
        receiver_mail_id = "ven_mbahmed@taylorfarms.com"
    }
]

feature_flag = {
  EnableDeltaEvents = "false"
}

