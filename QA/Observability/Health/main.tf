module "health_sns" {

  source = "../../../modules/observability/sns"
  name = "alert-health-sns"
  display_name = "AWS Health Notifications"
  tags = {
    Environment = "QA"
    Project     = "Observability"
  }
}

module "health_eventbridge" {
  source = "../../../modules/observability/eventbridge"
  event_bus_name = "observability-qa"
  description = "Monitoreo Health de aws"
  rule_name = "aws-health-events"
  event_pattern = jsonencode({
    source = [
      "aws.health"
    ]
  })

  target_arn = module.health_sns.arn

  tags = {
    Environment = "QA"
    Project     = "Observability"
  }
}

module "chatbot_role" {
  source = "../../../modules/observability/role"
  role_name = "observability-chatbot-role"
  tags = {
    Environment = "QA"
    Project     = "Observability"
  }
}

module "slack_chatbot" {
  source = "../../../modules/observability/chatbot"
  configuration_name = "observability-qa"
  slack_team_id = "T03MN099YP6"
  slack_channel_id = "C0BH1REFAPL"
  iam_role_arn = module.chatbot_role.arn
  sns_topic_arns = [module.health_sns.arn]
  tags = {
    Environment = "QA"
    Project     = "Observability"
  }
}