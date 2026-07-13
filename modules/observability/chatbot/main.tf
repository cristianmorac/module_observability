resource "aws_chatbot_slack_channel_configuration" "this" {
  configuration_name = var.configuration_name
  iam_role_arn = var.iam_role_arn
  slack_channel_id = var.slack_channel_id
  slack_team_id = var.slack_team_id

  tags = var.tags
}