output "id" {
  value       = azurerm_storage_account.storageaccount.id
  description = "The ID of the Storage Account."
}

output "name" {
  value       = azurerm_storage_account.storageaccount.name
  description = "The Name of the Storage Account."
}

output "primary_location" {
  value       = azurerm_storage_account.storageaccount.primary_location
  description = "The primary location of the storage account."
}

output "secondary_location" {
  value       = azurerm_storage_account.storageaccount.secondary_location
  description = "The secondary location of the storage account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_blob_host" {
  value       = azurerm_storage_account.storageaccount.primary_blob_host
  description = "The hostname with port if applicable for blob storage in the primary location."
}

output "secondary_blob_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_blob_endpoint
  description = "The endpoint URL for blob storage in the secondary location."
}

output "secondary_blob_host" {
  value       = azurerm_storage_account.storageaccount.secondary_blob_host
  description = "The hostname with port if applicable for blob storage in the secondary location."
}

output "primary_queue_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_queue_endpoint
  description = "The endpoint URL for queue storage in the primary location."
}

output "primary_queue_host" {
  value       = azurerm_storage_account.storageaccount.primary_queue_host
  description = "The hostname with port if applicable for queue storage in the primary location."
}

output "secondary_queue_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_queue_endpoint
  description = "The endpoint URL for queue storage in the secondary location."
}

output "secondary_queue_host" {
  value       = azurerm_storage_account.storageaccount.secondary_queue_host
  description = "The hostname with port if applicable for queue storage in the secondary location."
}

output "primary_table_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_table_endpoint
  description = "The endpoint URL for table storage in the primary location."
}

output "primary_table_host" {
  value       = azurerm_storage_account.storageaccount.primary_table_host
  description = "The hostname with port if applicable for table storage in the primary location."
}

output "secondary_table_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_table_endpoint
  description = "The endpoint URL for table storage in the secondary location."
}

output "secondary_table_host" {
  value       = azurerm_storage_account.storageaccount.secondary_table_host
  description = "The hostname with port if applicable for table storage in the secondary location."
}

output "primary_file_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_file_endpoint
  description = "The endpoint URL for file storage in the primary location."
}

output "primary_file_host" {
  value       = azurerm_storage_account.storageaccount.primary_file_host
  description = "The hostname with port if applicable for file storage in the primary location."
}

output "secondary_file_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_file_endpoint
  description = "The endpoint URL for file storage in the secondary location."
}

output "secondary_file_host" {
  value       = azurerm_storage_account.storageaccount.secondary_file_host
  description = "The hostname with port if applicable for file storage in the secondary location."
}

output "primary_dfs_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the primary location."
}

output "primary_dfs_host" {
  value       = azurerm_storage_account.storageaccount.primary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the primary location."
}

output "secondary_dfs_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_dfs_endpoint
  description = "The endpoint URL for DFS storage in the secondary location."
}

output "secondary_dfs_host" {
  value       = azurerm_storage_account.storageaccount.secondary_dfs_host
  description = "The hostname with port if applicable for DFS storage in the secondary location."
}

output "primary_web_endpoint" {
  value       = azurerm_storage_account.storageaccount.primary_web_endpoint
  description = "The endpoint URL for web storage in the primary location."
}

output "primary_web_host" {
  value       = azurerm_storage_account.storageaccount.primary_web_host
  description = "The hostname with port if applicable for web storage in the primary location."
}

output "secondary_web_endpoint" {
  value       = azurerm_storage_account.storageaccount.secondary_web_endpoint
  description = "The endpoint URL for web storage in the secondary location"
}

output "secondary_web_host" {
  value       = azurerm_storage_account.storageaccount.secondary_web_host
  description = "The endpoint URL for web storage in the primary location."
}

output "primary_access_key" {
  value       = azurerm_storage_account.storageaccount.primary_access_key
  description = "The primary access key for the storage account."
}

output "secondary_access_key" {
  value       = azurerm_storage_account.storageaccount.secondary_access_key
  description = "The secondary access key for the storage account."
}

output "primary_connection_string" {
  value       = azurerm_storage_account.storageaccount.primary_connection_string
  description = "The connection string associated with the primary location"
}

output "secondary_connection_string" {
  value       = azurerm_storage_account.storageaccount.secondary_connection_string
  description = "The connection string associated with the secondary location."
}

output "primary_blob_connection_string" {
  value       = azurerm_storage_account.storageaccount.primary_blob_connection_string
  description = "The connection string associated with the primary blob location."
}

output "secondary_blob_connection_string" {
  value       = azurerm_storage_account.storageaccount.secondary_blob_connection_string
  description = "The connection string associated with the secondary blob location."
}

