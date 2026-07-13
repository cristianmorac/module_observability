resource "aws_sns_topic" "this" {
  name = var.name
  display_name = var.display_name
  tags = var.tags
}

resource "aws_sns_topic_policy" "this" {
  arn = aws_sns_topic.this.arn
  policy = data.aws_iam_policy_document.this.json
}

data "aws_iam_policy_document" "this" {

  statement {
    sid    = "AllowEventBridgeToPublish"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["events.amazonaws.com"]
    }

    actions = [
      "sns:Publish"
    ]

    resources = [
      aws_sns_topic.this.arn
    ]
  }

  statement {
    sid    = "AllowChatbotToSubscribe"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["chatbot.amazonaws.com"]
    }

    actions = [
      "sns:GetTopicAttributes",
      "sns:Subscribe"
    ]

    resources = [
      aws_sns_topic.this.arn
    ]
  }
}