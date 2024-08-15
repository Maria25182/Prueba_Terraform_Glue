resource "aws_s3_bucket" "s3_example" {
  bucket = "bucket-glue-tecnic"

  tags = {
    Name        = "pTecnic"
    Environment = "Dev"
  }
}

resource "aws_s3_object" "folder_object" {
  bucket = aws_s3_bucket.s3_example.bucket
  key    = "input/"

}

resource "aws_s3_object" "object_glue_job" {
  bucket = aws_s3_bucket.s3_example.bucket
  key    = "glue/scripts/glue_job.py"
  source = "./glue_code/glue_job_one/glue_job.py"
}

###permisoss para que invoque la lambda
resource "aws_lambda_permission" "s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_name
  principal     = "s3.amazonaws.com"
  source_arn    = aws_s3_bucket.s3_example.arn
}
##trigger
resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.s3_example.id

  lambda_function {
    lambda_function_arn = var.lambda_arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "input/"
  }
}