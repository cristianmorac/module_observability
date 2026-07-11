module "health_sns" {

  source = "../../modules/observability/sns"
  name = "alert-health-sns"
  display_name = "AWS Health Notifications"
  tags = {
    Environment = "QA"
    Project     = "Observability"
  }
}