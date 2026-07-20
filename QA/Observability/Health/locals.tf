locals {

  Project = "Notify_Health"

  # SNS
  sns_display_name = "AWS Health Notifications"

  # Eventbridge
  bus_description = "Monitoreo Health de aws"
  event_pattern = ["aws.health"]


  # Chatbot
  
  ## Role chatbot
  chatbot_role_arn = coalesce(
    var.iam_role_arn,
    module.chatbot_role.role_arn_chatbot
  )
  ## Slack
  team_id = "T03MN099YP6"
  channel_id = "C0BH1REFAPL"

  # Tags
  default_tg = {
    Owner = "CloudTeam"
    Environment = "QA"
    CostCenter = "CC1"
    ManagedBy = "Terraform"
    Application = "Observability_Health"
  }

}