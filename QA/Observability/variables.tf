variable "iam_role_arn" {
  type    = string
  default = null
}

variable "enabled" {
  description = "Habilita la creación de los recursos de observabilidad"
  type        = bool
  default     = true
}