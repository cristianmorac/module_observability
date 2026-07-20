variable "role_name" {
  description = "IAM role name."
  type        = string
}

variable "managed_policy_arns" {
  description = "List of AWS managed or customer managed policy ARNs to attach to the role."
  type        = list(string)

  default = [
    "arn:aws:iam::aws:policy/ReadOnlyAccess"
  ]
}

variable "inline_policy_json" {
  description = "Optional inline IAM policy in JSON format."
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the IAM role."
  type        = map(string)
  default     = {}
}