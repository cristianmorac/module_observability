output "sns_arn" {
  value = {
    for k, v in module.health_sns :
    k => v.arn
  }
}

output "sns_name" {
  value = {
    for k, v in module.health_sns :
    k => v.name
  }
}

output "role_arn_chatbot" {
  value = module.chatbot_role.role_arn_chatbot
}