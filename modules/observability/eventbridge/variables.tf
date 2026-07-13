variable "rule_name" {
  type = string
}

variable "description" {
  type = string
}

variable "event_bus_name" {
  type        = string
  description = "Nombre de la regla"
}

variable "event_pattern" {
  type = string
}

variable "target_arn" {
  type = string
}

variable "tags" {
  type    = map(string)
  default = {}
}

