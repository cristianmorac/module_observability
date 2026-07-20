module "health_sns" {

  source = "../../../modules/observability/sns"
  name = "alert-health-sns"
  display_name = "AWS Health Notifications"
  tags = merge(local.default_tg, {
    Name = "alert-health-sns"
    Component = "SNS"
  })
}

module "health_eventbridge" {
  source = "../../../modules/observability/eventbridge"
  event_bus_name = "observability-qa"
  description = "Monitoreo Health de aws"
  rule_name = "events-rule-health"
  event_pattern = jsonencode({
    source = [
      "aws.health"
    ]
  })

  target_arn = module.health_sns.arn

  tags = merge(local.default_tg, {
    Name = "Event_rule_Health"
    Component = "Eventbridge"
  })
}

module "chatbot_role" {
  source = "../../../modules/observability/role"
  role_name = "observability-chatbot-role"
  tags = merge(local.default_tg, {
    Name = "Chatbot_role_Health"
    Component = "Role"
  })
}

module "slack_chatbot" {
  source = "../../../modules/observability/chatbot"
  configuration_name = "observability-qa"
  slack_team_id = "T03MN099YP6"
  slack_channel_id = "C0BH1REFAPL"
  iam_role_arn = module.chatbot_role.arn
  sns_topic_arns = [module.health_sns.arn]
  tags = merge(local.default_tg, {
    Name = "Chatbot_Health"
    Component = "Chatbot"
  })
}