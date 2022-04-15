# Module Version
variable "azurerm_keyvault_version" {
  type        = string
  default     = "1.0"
  description = "The current version of this module."
}

variable "keyvault_name" {
  type        = string
  description = "The name of the keyvault."
}
variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type = map(string)
}

variable "sku_name" {
  type        = string
  default     = "premium"
  description = "The Name of the SKU used for this Key Vault. Possible values are standard and premium"

  validation {
    condition     = var.sku_name == "premium" || var.sku_name == "standard"
    error_message = "The value for sku_name can only be \"premium\" or \"standard\"!"
  }
}

variable "enabled_for_deployment" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Virtual Machines are permitted to retrieve certificates stored as secrets from the key vault."
}


variable "enabled_for_disk_encryption" {
  type        = bool
  default     = true
  description = "Boolean flag to specify whether Azure Disk Encryption is permitted to retrieve secrets from the vault and unwrap keys. "
}

variable "enabled_for_template_deployment" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Resource Manager is permitted to retrieve secrets from the key vault."
}

variable "enable_rbac_authorization" {
  type        = bool
  default     = false
  description = "Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions."
}

variable "purge_protection_enabled" {
  type        = bool
  default     = true
  description = "Is Purge Protection enabled for this Key Vault?"
}

variable "soft_delete_retention_days" {
  type    = number
  default = 90
}

variable "contact" {
  type        = list(any)
  default     = []
  description = null
}

variable "current_user_certificate_permissions" {
  type        = list(string)
  default     = ["Backup", "Create", "Delete", "Deleteissuers", "Get", "Getissuers", "Import", "List", "Listissuers", "ManageContacts", "Manageissuers", "Purge", "Recover", "Restore", "Setissuers", "Update"]
  description = "List of certificate permissions, must be one or more from the following: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers and Update"
}

variable "current_user_key_permissions" {
  type        = list(string)
  default     = ["Backup", "Create", "Decrypt", "Delete", "Encrypt", "Get", "Import", "List", "Purge", "Recover", "Restore", "Sign", "UnwrapKey", "Update", "Verify", "WrapKey"]
  description = "List of key permissions, must be one or more from the following: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify and WrapKey"
}

variable "current_user_secret_permissions" {
  type        = list(string)
  default     = ["Backup", "Delete", "Get", "List", "Purge", "Recover", "Restore", "Set"]
  description = "List of secret permissions, must be one or more from the following: Backup, Delete, Get, List, Purge, Recover, Restore and Set"
}

variable "current_user_storage_permissions" {
  type        = list(string)
  default     = ["Backup", "Delete", "DeleteSAS", "Get", "GetSAS", "List", "ListSAS", "Purge", "Recover", "RegenerateKey", "Restore", "Set", "SetSAS", "Update"]
  description = "List of storage permissions, must be one or more from the following: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS and Update"
}

# firewall
variable "network_acls_default_action" {
  type        = string
  default     = "Deny"
  description = "The Default Action to use when no rules match from ip_rules / virtual_network_subnet_ids. Possible values are Allow and Deny"

  validation {
    condition     = var.network_acls_default_action == "Allow" || var.network_acls_default_action == "Deny"
    error_message = "The value for network_acls_default_action can only be \"Allow\" or \"Deny\"!"
  }
}

variable "network_acls_bypass" {
  type        = string
  default     = "AzureServices"
  description = "Specifies which traffic can bypass the network rules. Possible values are AzureServices and None"

  validation {
    condition     = var.network_acls_bypass == "AzureServices" || var.network_acls_bypass == "None"
    error_message = "The value for network_acls_bypass can only be \"AzureServices\" or \"None\"!"
  }
}

variable "allow_ips" {
  type        = list(string)
  default     = null
  description = "One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault."
}

variable "allow_subnets" {
  type        = list(string)
  default     = []
  description = "One or more Subnet ID's which should be able to access this Key Vault."
}

# Access Policies
variable "key_vault_access_policy_list" {
  type        = list(any)
  default     = []
  description = null
}

# Diagnostic settings
variable "diagnostic_settings_enabled" {
  type        = bool
  default     = true
  description = "Specifies the enablement of the diagnostic monitoring for the Key Vault resource."
}

variable "storage_account_id" {
  type        = string
  default     = null
  description = "The ID of the Storage Account where logs should be sent. Changing this forces a new resource to be created."
}

variable "eventhub_name" {
  type        = string
  default     = null
  description = "Specifies the name of the Event Hub where Diagnostics Data should be sent. Changing this forces a new resource to be created."
}

variable "eventhub_authorization_rule_id" {
  type        = string
  default     = null
  description = "Specifies the ID of an Event Hub Namespace Authorization Rule used to send Diagnostics Data. Changing this forces a new resource to be created."
}

variable "log_analytics_workspace_id" {
  type        = string
  default     = null
  description = "Specifies the ID of a Log Analytics Workspace where Diagnostics Data should be sent."
}

variable "log_analytics_destination_type" {
  type        = string
  default     = null
  description = "When set to 'Dedicated' logs sent to a Log Analytics workspace will go into resource specific tables, instead of the legacy AzureDiagnostics table."
}

variable "log_category" {
  type        = string
  default     = "AuditEvent"
  description = "The name of a Diagnostic Log Category for this Resource. For Key Vault the only supported value is \"AuditEvent\""

  validation {
    condition     = var.log_category == "AuditEvent"
    error_message = "The value for log_category can only be \"AuditEvent\" until now!"
  }
}

# Diagnostic settings - logs
variable "log_enabled" {
  type        = bool
  default     = true
  description = "Is this Diagnostic Log enabled?"
}

variable "log_retention_policy_enabled" {
  type        = bool
  default     = true
  description = "Is this Retention Policy enabled?"
}

variable "log_retention_days" {
  type        = number
  default     = 365
  description = "The number of days for which this Retention Policy should apply."
}

# Diagnostic settings - metrics
variable "metric_category" {
  type        = string
  default     = "AllMetrics"
  description = "The name of a Diagnostic Metric Category for this Resource.For Key Vault the only supported value is \"AllMetrics\""

  validation {
    condition     = var.metric_category == "AllMetrics"
    error_message = "The value for metric_category can only be \"AllMetrics\" until now!"
  }
}

variable "metric_retention_policy_enabled" {
  type        = bool
  default     = true
  description = "Is this Retention Policy enabled?"
}

variable "metric_retention_days" {
  type        = number
  default     = 365
  description = "The number of days for which this Retention Policy should apply."
}
