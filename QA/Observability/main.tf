locals {
  enabled_projects = {
    for name, project in local.projects :
    name => project
    if project.enabled
  }
}

module "health_sns" {

  for_each = local.enabled_projects

  source = "../../modules/observability/sns"

  name         = "alert-${each.key}"
  display_name = each.value.sns.display_name

  tags = merge(each.value.default_tags, {
    Name      = "alert-${each.key}"
    Component = "SNS"
  })
}

module "health_eventbridge" {

  for_each = local.enabled_projects

  source = "../../modules/observability/eventbridge"

  event_bus_name = "observability-${each.key}"
  description    = each.value.eventbridge.bus_description
  rule_name      = "events-rule-${each.key}"

  event_pattern = jsonencode({
    source = each.value.eventbridge.event_pattern
  })

  target_arn = module.health_sns[each.key].arn

  tags = merge(each.value.default_tags, {
    Name      = "Event_rule-${each.key}"
    Component = "Eventbridge"
  })
}

module "chatbot_role" {

  source = "../../modules/observability/role/Chatbot"

  role_name = "observability-chatbot-role-chatbot-role"

  tags = merge(local.tags, {
    Name      = "Chatbot_role-observability"
    Component = "Role"
  })
}

module "slack_chatbot" {

  for_each = local.enabled_projects

  source = "../../modules/observability/chatbot"

  configuration_name = "observability-${each.key}"

  slack_team_id    = each.value.chatbot.team_id
  slack_channel_id = each.value.chatbot.channel_id

  iam_role_arn = module.chatbot_role.role_arn_chatbot

  sns_topic_arns = [
    module.health_sns[each.key].arn
  ]

  tags = merge(each.value.default_tags, {
    Name      = "Chatbot-${each.key}"
    Component = "Chatbot"
  })
}