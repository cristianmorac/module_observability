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