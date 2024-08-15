output "lambda_role_arn" {
  value = aws_iam_role.iam_for_lambda.arn
} 
output "glue_role_arn" {
  value = aws_iam_role.glue_role.arn
} 
