variable "configuration_name" {
  type = string
}

variable "slack_team_id" {
  type = string
}

variable "slack_channel_id" {
  type = string
}

variable "sns_topic_arns" {
  type = list(string)
}

variable "iam_role_arn" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {}
}