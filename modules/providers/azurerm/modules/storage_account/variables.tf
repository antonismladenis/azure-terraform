# Module Version
variable "azurerm_storage_acount_version" {
  type        = string
  default     = "1.0"
  description = "The current version of this module."
}

# Variables that need values
variable "storage_account_name" {
  type        = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "The resource group name in which the storage account will be created."
}

variable "location" {
  type        = string
  description = "The location in which the storage account will be created."

}

variable "tags" {
  type        = map(string)
  description = "Azure Tags"
}

# Variables that don't need to be configured
variable "account_tier" {
  type        = string
  default     = "Standard"
  description = null
}

variable "access_tier" {
  type        = string
  default     = "Hot"
  description = <<EOF
Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool
EOF
}

variable "account_kind" {
  type        = string
  default     = "StorageV2"
  description = null
}

variable "account_replication_type" {
  type        = string
  default     = "GRS"
  description = <<EOF
  Defines the type of replication to use for this storage account.
  Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS
EOF
}

variable "enable_https_traffic_only" {
  type        = bool
  default     = true
  description = "Boolean flag which forces HTTPS if enabled, see https://docs.microsoft.com/en-us/azure/storage/common/storage-require-secure-transfer for more information."
}

variable "min_tls_version" {
  type        = string
  default     = "TLS1_2"
}

variable "is_hns_enabled" {
  type        = bool
  default     = false
}

variable "nfsv3_enabled" {
  type        = bool
  default     = false
}

variable "large_file_share_enabled" {
  type        = bool
  default     = false
  description = "Is Large File Share Enabled?"
}

# routing block properties
variable "routing" {
  type        = bool
  default     = false
  description = "If you want to enable routing assign to this variable the value true."
}

variable "routing_publish_internet_endpoints" {
  type        = bool
  default     = false
  description = "Should internet routing storage endpoints be published?"
}

variable "routing_publish_microsoft_endpoints" {
  type        = bool
  default     = false
  description = "Should microsoft routing storage endpoints be published?"
}

variable "routing_choice" {
  type        = string
  default     = "MicrosoftRouting"
  description = <<EOF
Specifies the kind of network routing opted by the user.
Possible values are InternetRouting and MicrosoftRouting
EOF
}

# static website block properties
variable "static_website_index_document" {
  type        = string
  default     = ""
  description = <<EOF
The webpage that Azure Storage serves for requests to the root of a website or any subfolder.
For example, index.html. The value is case-sensitive.
EOF
}

variable "static_website_error_404_document" {
  type        = string
  default     = ""
  description = <<EOF
The absolute path to a custom webpage that should be used
when a request is made which does not correspond to an existing file.
EOF
}

variable "custom_domain_name" {
  type        = string
  default     = ""
  description = "The Custom Domain Name to use for the Storage Account, which will be validated by Azure."
}

variable "custom_domain_use_subdomain" {
  type        = bool
  default     = null
  description = "Should the Custom Domain Name be validated by using indirect CNAME validation?"
}

# firewall properties
variable "allow_blob_public_access" {
  type        = bool
  default     = false
  description = "Allow or disallow public access to all blobs or containers in the storage account. "
}

variable "allow_ips" {
  type        = list(string)
  default     = null
  description = "List of public IP or IP ranges in CIDR Format. Only IPV4 addresses are allowed. Private IP address ranges (as defined in RFC 1918) are not allowed."
}

variable "allow_subnets" {
  type        = list(string)
  default     = []
  description = "A list of resource ids for subnets."
}

variable "firewall_default_action" {
  type        = string
  default     = "Deny"
  description = "\"Allow\" or \"Deny\""

  validation {
    condition     = var.firewall_default_action == "Allow" || var.firewall_default_action == "Deny"
    error_message = "The value for firewall_default_action can only be \"Allow\" or \"Deny\"!"
  }
}

variable "storage_account_network_rules_bypass" {
  type        = list(string)
  default     = ["AzureServices"]
  description = <<EOF
  Specifies whether traffic is bypassed for Logging/Metrics/AzureServices. 
  Valid options are any combination of Logging, Metrics, AzureServices, or None
EOF
}

# private link block properties
variable "private_link_access" {
  type        = list(any)
  default     = []
  description = <<EOF
  * endpoint_resource_id -->(string(azure Id))(required) The resource id of the resource access rule to be granted access.
  * endpoint_tenant_id -->(string(azure Id))(optional) The tenant id of the resource of the resource access rule to be granted access. Defaults to the current tenant id.

  private_link_access = [
  {
    endpoint_resource_id = "resource_id"
    endpoint_tenant_id   = "tenant_id"
  },
  {
    endpoint_resource_id = "resource_id"
  }
  ]
EOF
}

# identity block properties
variable "identity" {
  type        = list(any)
  default     = []
  description = <<EOF
  * type -->(string)(required) Specifies the identity type of the Storage Account. Possible values are SystemAssigned, UserAssigned, SystemAssigned,UserAssigned (to enable both).
  * identity_ids -->(list)(required when type=="UserAssigned" || type=="SystemAssigned,UserAssigned" ) A list of IDs for User Assigned Managed Identity resources to be assigned.

  example:
  identity = [
  {
    type = "SystemAssigned"
  },
  {
    type = "UserAssigned"
    identity_ids   = ["identity_ids"]
  }
  ]
EOF
}

# blob block properties
variable "blob_properties" {
  type        = bool
  default     = false
  description = "If you want to enable blob_properties assign to this variable the value true."
}

variable "blob_properties_cors_rule" {
  type        = list(any)
  default     = []
  description = <<EOF
  * allowed_headers -->(list)(required) A list of headers that are allowed to be a part of the cross-origin request.
  * allowed_methods -->(list)(required) A list of http headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
  * allowed_origins -->(list)(required) A list of origin domains that will be allowed by CORS.
  * exposed_headers -->(list)(required) A list of response headers that are exposed to CORS clients.
  * max_age_in_seconds -->(number)(required) The number of seconds the client should cache a preflight response.
  example:
  blob_properties_cors_rule = [
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["GET"]
    allowed_origins   = ["*.us"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 8
  },
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["DELETE"]
    allowed_origins   = ["*.com"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 15
  }
  ]
EOF
}

variable "blob_properties_versioning_enabled" {
  type        = bool
  default     = false
  description = "Is versioning enabled?"
}

variable "blob_properties_default_service_version" {
  type        = string
  default     = "2020-06-12"
  description = "The API Version which should be used by default for requests to the Data Plane API if an incoming request doesn't specify an API Version."
}

variable "blob_properties_last_access_time_enabled" {
  type        = bool
  default     = false
  description = "Is the last access time based tracking enabled?"
}

variable "blob_properties_delete_retention_policy_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days."
}

variable "blob_properties_container_delete_retention_policy_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days that the container should be retained, between 1 and 365 days."
}

# queue block properties
variable "queue_properties" {
  type        = bool
  default     = false
  description = "If you want to enable queue_properties assign to this variable the value true."
}

variable "queue_properties_cors_rule" {
  type        = list(any)
  default     = []
  description = <<EOF
  * allowed_headers -->(list)(required) A list of headers that are allowed to be a part of the cross-origin request.
  * allowed_methods -->(list)(required) A list of http headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
  * allowed_origins -->(list)(required) A list of origin domains that will be allowed by CORS.
  * exposed_headers -->(list)(required) A list of response headers that are exposed to CORS clients.
  * max_age_in_seconds -->(number)(required) The number of seconds the client should cache a preflight response.
  example:
  queue_properties_cors_rule = [
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["GET"]
    allowed_origins   = ["*.us"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 8
  },
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["DELETE"]
    allowed_origins   = ["*.com"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 15
  }
  ]
EOF
}

variable "queue_properties_logging" {
  type        = map(any)
  default     = null
  description = <<EOF
  * delete -->(bool)(required)  Indicates whether all delete requests should be logged. Changing this forces a new resource.
  * read -->(bool)(required) Indicates whether all read requests should be logged. Changing this forces a new resource.
  * version -->(string)(required) The version of storage analytics to configure. Changing this forces a new resource.
  * write -->(bool)(required) Indicates whether all write requests should be logged. Changing this forces a new resource.
  * retention_policy_days -->(number)(optional)  Specifies the number of days that logs will be retained. Changing this forces a new resource.

  example:
  queue_properties_logging = {
    delete = false
    read = true
    version = "1.0"
    write = true
    retention_policy_days = 7
  }
EOF
}

variable "queue_properties_minute_metrics" {
  type        = map(any)
  default     = null
  description = <<EOF
  * enabled -->(bool)(required)  Indicates whether minute metrics are enabled for the Queue service. Changing this forces a new resource.
  * version  -->(string)(required) The version of storage analytics to configure. Changing this forces a new resource.
  * include_apis -->(bool)(optional)  Indicates whether metrics should generate summary statistics for called API operations.
  * retention_policy_days -->(number)(optional) Specifies the number of days that logs will be retained. Changing this forces a new resource.

  example:
  queue_properties_minute_metrics = {
    enabled = false
    version = "1.0"
    include_apis = false
  }
EOF
}

variable "queue_properties_hour_metrics" {
  type        = map(any)
  default     = null
  description = <<EOF
  * enabled -->(bool)(required)  Indicates whether minute metrics are enabled for the Queue service. Changing this forces a new resource.
  * version  -->(string)(required) The version of storage analytics to configure. Changing this forces a new resource.
  * include_apis -->(bool)(optional)  Indicates whether metrics should generate summary statistics for called API operations.
  * retention_policy_days -->(number)(optional) Specifies the number of days that logs will be retained. Changing this forces a new resource.

  example:
  queue_properties_hour_metrics = {
    enabled = false
    version = "1.0"
    include_apis = false
    retention_policy_days = 8
  }
EOF
}


# share block properties
variable "share_properties" {
  type        = bool
  default     = false
  description = "If you want to enable share_properties assign to this variable the value true."
}

variable "share_properties_cors_rule" {
  type        = list(any)
  default     = []
  description = <<EOF
  * allowed_headers -->(list)(required) A list of headers that are allowed to be a part of the cross-origin request.
  * allowed_methods -->(list)(required) A list of http headers that are allowed to be executed by the origin. Valid options are DELETE, GET, HEAD, MERGE, POST, OPTIONS, PUT or PATCH
  * allowed_origins -->(list)(required) A list of origin domains that will be allowed by CORS.
  * exposed_headers -->(list)(required) A list of response headers that are exposed to CORS clients.
  * max_age_in_seconds -->(number)(required) The number of seconds the client should cache a preflight response.
  example:
  share_properties_cors_rule = [
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["GET"]
    allowed_origins   = ["*.us"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 8
  },
  {
    allowed_headers = ["headers"]
    allowed_methods   = ["DELETE"]
    allowed_origins   = ["*.com"]
    exposed_headers   = ["header"]
    max_age_in_seconds = 15
  },
  ]
EOF
}

variable "share_properties_retention_policy_days" {
  type        = number
  default     = 7
  description = "Specifies the number of days that the azurerm_storage_share should be retained, between 1 and 365 days."
}

variable "share_properties_smb" {
  type        = map(any)
  default     = null
  description = <<EOF
  * versions -->(list)(optional) A set of SMB protocol versions. Possible values are SMB2.1, SMB3.0, and SMB3.1.1
  * authentication_types --> (list)(optional) A set of SMB authentication methods. Possible values are NTLMv2, and Kerberos
  * kerberos_ticket_encryption_type -->(list)(optional) A list of origin domains that will be allowed by CORS.
  * channel_encryption_type -->(list)(optional) A list of response headers that are exposed to CORS clients.

  example:
  share_properties_smb = {
    versions = ["SMB2.1"]
    authentication_types   = ["Kerberos"]
    kerberos_ticket_encryption_type   = ["AES-256"]
    channel_encryption_type   = ["AES-128-CCM"]
  }
EOF
}

# azure_files_authentication block properties
variable "azure_files_authentication_directory_type" {
  type        = map(any)
  default     = null
}

#variables for private endpoint


variable "private_endpoint_list" {
  # type        = list(map(any))
  description = <<EOF
* private_endpoint_name --> (string) (Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created.
* subresource_names --> (list)(Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id.

example:
private_endpoint_list = [
{
  private_endpoint_name = "files001-endpoint"
  subresource_names = ["file"]
}
]
EOF
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "The subnet id which will host the private endpoint."
  default     = null
}

variable "private_dns_zone_group_name" {
  type        = string
  description = "Specifies the Name of the Private DNS Zone Group. Changing this forces a new private_dns_zone_group resource to be created."
  default     = null
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "Specifies the list of Private DNS Zones to include within the private_dns_zone_group."
  default     = []
}
