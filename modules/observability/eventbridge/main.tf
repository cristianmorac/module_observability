resource "aws_cloudwatch_event_bus" "this" {
  name = var.event_bus_name
  tags = var.tags
}

resource "aws_cloudwatch_event_rule" "this" {
  name           = var.rule_name
  description    = var.description
  event_bus_name = aws_cloudwatch_event_bus.this.name
  event_pattern  = var.event_pattern
  tags           = var.tags
}

resource "aws_cloudwatch_event_target" "this" {
  rule           = aws_cloudwatch_event_rule.this.name
  event_bus_name = aws_cloudwatch_event_bus.this.name

  target_id = "sns"
  arn       = var.target_arn
}

