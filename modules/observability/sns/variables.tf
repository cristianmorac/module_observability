variable "name" {
  description = "SNS Topic name"
  type        = string
}

variable "display_name" {
  description = "SNS display name"
  type        = string
  default     = null
}

variable "tags" {
  type    = map(string)
  default = {}
}