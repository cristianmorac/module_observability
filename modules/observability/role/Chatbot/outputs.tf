output "role_arn_chatbot" {
  value = aws_iam_role.this.arn
}

output "role_name_chatbot" {
  value = aws_iam_role.this.name
}