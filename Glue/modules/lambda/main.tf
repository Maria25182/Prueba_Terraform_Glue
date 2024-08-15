
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "./lambda_code/orq_lambda/lambda_function.py"
  output_path = "lambda_function_payload.zip"
}

resource "aws_lambda_function" "test_lambda" {
  # If the file is not in the current working directory you will need to include a
  # path.module in the filename.
  filename      = "lambda_function_payload.zip"
  function_name = "lambda_teste_tecnic"
  role          = var.iam_role_id
  handler       = "lambda_function.lambda_handler"

  source_code_hash = data.archive_file.lambda.output_base64sha256

  runtime = "python3.12"

  environment {
    variables = {
      foo = "Tenic"
    }
  }
}