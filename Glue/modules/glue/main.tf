resource "aws_glue_job" "example_glue_job" {
  name     = "glue-job-tecnic"
  role_arn = var.glue_role_arn

  command {
    name            = "glueetl"
    script_location = "s3://${var.s3_name}/glue/scripts/glue_job.py"
    python_version  = "3"
  }
  
  # Opciones del trabajo
  max_retries       = 0
  glue_version      = "3.0"
  number_of_workers = 10
  worker_type       = "G.1X" # o "G.1X" para más memoria

  # Parámetros opcionales
  default_arguments = {
    "--job-language"     = "python"
    "--enable-metrics"   = "true"
    "--TempDir"          = "s3://my-glue-temp-bucket/temp-dir/"
    "--additional-python-modules" = "boto3==1.18.1,pandas==1.3.1"
  }

}