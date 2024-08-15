module "iam" {
  source = "./modules/iam"
}
module "dynamo" {
  source = "./modules/dynamo"
}
module "lambda" {
  source      = "./modules/lambda"
  iam_role_id = module.iam.lambda_role_arn
}

module "s3" {
  source = "./modules/s3"
  lambda_arn = module.lambda.lambda_arn
  lambda_name = module.lambda.lambda_name
}

module "cloudwatch" {
  source      = "./modules/cloudwatch"
  lambda_name = module.lambda.lambda_name
}

module "glue" {
  source      = "./modules/glue"
  glue_role_arn = module.iam.glue_role_arn
  s3_name = module.s3.s3_bucket_name
}

