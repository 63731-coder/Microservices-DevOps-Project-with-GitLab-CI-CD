variable "location" {
  description = "Azure region"
  type        = string
  default     = "West Europe"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
  default     = "rg-microservices-app"
}

variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
  default     = "scenarioregistry63731"
}

variable "identity_name" {
  description = "Name of the user-assigned managed identity"
  type        = string
  default     = "container-app-identity"
}

variable "service_plan_name" {
  description = "Name of the App Service plan"
  type        = string
  default     = "appserviceplan"
}

variable "docker_image_python" {
  description = "Docker image name and tag"
  type        = string
  default     = "63731-service-python:latest"
}

variable "web_app_port_python" {
  description = "Port on which the web app listens"
  type        = string
  default     = "5000"
}

variable "docker_image_java" {
  description = "Docker image name and tag"
  type        = string
  default     = "63731-service-java:latest"
}

variable "web_app_port_java" {
  description = "Port on which the web app listens"
  type        = string
  default     = "8080"
}

variable "web_app_python" {
  description = "Name of the Web App"
  type        = string
  default     = "mon-app-python-63731"
}

variable "web_app_java" {
  description = "Name of the Web App"
  type        = string
  default     = "mon-app-java-63731"
}

variable "arm_client_id" {
  description = "Azure Client ID (service principal)"
  type        = string
  default     = "24cf5924-aa8d-4a8a-ad21-619b9ad3a3f5"
}

variable "arm_client_secret" {
  description = "Azure Client Secret"
  type        = string
  default     = "coZ8Q~HtruSbPvYnOTOvpq.XA~x5fPAKQLz1JcW2"
  sensitive   = true
}

variable "arm_subscription_id" {
  description = "Azure Subscription ID"
  type        = string
  default     = "c89b9524-5918-4457-b046-b6ad9541bc2f"
}

variable "arm_tenant_id" {
  description = "Azure Tenant ID"
  type        = string
  default     = "1028c7be-cb55-4d25-9e35-fb499070f658"
}
