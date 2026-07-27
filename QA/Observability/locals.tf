locals {
  tags = {
    Owner       = "CloudTeam"
    Environment = "QA"
    CostCenter  = "CC1"
    ManagedBy   = "Terraform"
    Application = "Observability_Health"
  }
  projects = {
    Notify_Health = {
      enabled = true

      sns = {
        display_name = "AWS Health Notifications"
      }

      eventbridge = {
        bus_description = "Monitoreo Health de AWS"
        event_pattern = {
          source = [
            "aws.health"
          ]
        }
      }

      chatbot = {
        team_id    = "T03MN099YP6"
        channel_id = "C0BH1REFAPL"
      }

      default_tags = local.tags
    }

    Notify_Backup = {
      enabled = false

      sns = {
        display_name = "Backup Notifications"
      }

      eventbridge = {
        bus_description = "Monitoring Backup"
        event_pattern = {
          source = [
            "aws.backup"
          ]
          "detail-type" = [
            "Backup Job State Change"
          ]
          detail = {
            state = [
              "COMPLETED"
            ]
          }
        }
      }

      chatbot = {
        team_id    = "T03MN099YP6"
        channel_id = "C0BH1REFAPL"
      }
      default_tags = local.tags
    }
  }
}