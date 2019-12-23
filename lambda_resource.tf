data "aws_caller_identity" "current" {}

data "aws_s3_bucket_object" "lambda_zip_file" {
  bucket = "${local.this_env_prefix}-${var.bucket_name}"
  key    = "${var.s3_key}"
}

module "lambda_security_group" {
  source      = "./modules/sgs"
  name        = "${local.this_env_prefix}-sg-${var.function_name}"
  description = "${var.security_group_description}-${var.function_name}" 
  vpc_id      = "${var.vpc_id}"
  ingress     = "${var.ingress}"
  egress      = "${var.egress}"
}

module "lambda_role" {
  source                         = "./modules/sec"
  function_name                  = "${local.this_env_prefix}-${var.function_name}"
  account_id                     = "${data.aws_caller_identity.current.account_id}"
  bucket_name                    = "${local.this_env_prefix}-${var.bucket_name}"
}

module "lambda" {
  source                        = "./modules/lambda"
  function_name                 = "${local.this_env_prefix}-${var.function_name}"
  description                   = "${var.lambda_description}"
  runtime                       = "${var.runtime}"
  s3_bucket                     = "${local.this_env_prefix}-${var.bucket_name}"
  s3_key                        = "${var.s3_key}"
  #s3_object_version            = "${data.aws_s3_bucket_object.lambda_zip_file.version_id}"
  handler                       = "${var.lambda_handler}"
  source_code_hash              = "${base64sha256(file("${var.lambda_file}"))}"
  aws_account                   = "${var.aws-account}"
  role                          = "${module.lambda_role.arn}"
  account_id                    = "${data.aws_caller_identity.current.account_id}" 
  vpc_id                        = "${var.vpc_id}" 
  subnet_ids                    = ["${var.subnet_ids}"]  
  security_group_ids            = ["${module.lambda_security_group.id}"]
  timeout                       = "${var.timeout}"
  memory_size                   = "${var.memory_size}"
  layer_arn                     = ["${module.lambda.layer_arn}"]
  s3_key_layer                  = "${var.s3_key_layer}"
  layer_name                    = "${var.layer_name}" 
  layer_runtimes                = ["${var.layer_runtimes}"]
  
  environment { 
    variables {
      env        = "${var.aws-account}"
    }
  }         
}

module "lambda_permission" {
  source        = "./modules/lambda_permission"
  statement_id  = "${var.statement_id}"
  action        = "${var.action}"
  function_name = "${module.lambda.function_name}"
  principal     = "${var.principal}"
  source_arn    = "arn:aws:execute-api:${var.region}:${data.aws_caller_identity.current.account_id}:${module.api.id}/*/${module.api_methods.api_http_method}/${module.api_resource.api_path}"
}
