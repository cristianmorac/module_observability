output "sns_arn" {
  value = module.health_sns.arn
}

output "sns_name" {
  value = module.health_sns.name
}

output "chatbot_role" {
  value = module.chatbot_role.role_arn_chatbot
}