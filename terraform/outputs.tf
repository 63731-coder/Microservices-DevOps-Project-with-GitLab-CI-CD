output "container_registry_login_server" {
  description = "Adresse du registre ACR"
  value       = azurerm_container_registry.acr.login_server
}

output "web_app_url_java" {
  description = "URL complète de l'application java"
  value       = "https://${azurerm_linux_web_app.app-java.default_hostname}/proxy"
}

output "web_app_url_python" {
  description = "URL complète de l'application python"
  value       = "https://${azurerm_linux_web_app.app-python.default_hostname}/api/message"
}
