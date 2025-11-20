variable "rg_name" {
  type = string
  description = "Resource group name"
  default = "my-func-rg"
}

variable "rg_location" {
  type = string
  description = "Resource group nalocation"
  default = "canada central"
}

variable "asp_name" {
  type = string
  description = "App service plan name"
  default = "my-func-asp"
}

variable "func_name" {
  type = string
  description = "Function app name"
  default = "func-app"
}
