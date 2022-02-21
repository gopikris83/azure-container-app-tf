variable "app_name" {
  description = "App name"
  default     = "azcontainer-app"
}

variable "app_environment" {
  description = "App environment"
  default     = "Test"
}

variable "az_region" {
  default     = "North Europe"
  description = "az region where our resources going to create choose"
}

variable "az_count" {
  default     = "2"
  description = "number of availability zones in above region"
}

variable "key_name" {
  default = "azacrsecret1202"
}

variable "key_value" {
  default = ""
}