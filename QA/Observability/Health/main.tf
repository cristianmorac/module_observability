module "health_sns" {

  source = "../../../modules/observability/sns"
  name = "alert-${local.Project}"
  display_name = local.sns_display_name
  tags = merge(local.default_tg, {
    Name = "alert-${local.Project}"
    Component = "SNS"
  })
}

module "health_eventbridge" {
  source = "../../../modules/observability/eventbridge"
  event_bus_name = "observability-${local.Project}"
  description = local.bus_description
  rule_name = "events-rule-${local.Project}"
  event_pattern = jsonencode({
    source = local.event_pattern
  })

  target_arn = module.health_sns.arn

  tags = merge(local.default_tg, {
    Name = "Event_rule-${local.Project}"
    Component = "Eventbridge"
  })
}

module "chatbot_role" {
  source = "../../../modules/observability/role/Chatbot"
  role_name = "${local.Project}-chatbot-role"
  tags = merge(local.default_tg, {
    Name = "Chatbot_role-${local.Project}"
    Component = "Role"
  })
}

module "slack_chatbot" {
  source = "../../../modules/observability/chatbot"
  configuration_name = "observability-${local.Project}"
  slack_team_id = local.team_id
  slack_channel_id = local.channel_id
  iam_role_arn = local.chatbot_role_arn
  sns_topic_arns = [module.health_sns.arn]
  tags = merge(local.default_tg, {
    Name = "Chatbot-${local.Project}"
    Component = "Chatbot"
  })
}