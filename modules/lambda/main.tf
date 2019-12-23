resource "aws_lambda_function" "function" {
  runtime           = "${var.runtime}"
  description       = "${var.description}"
  function_name     = "${var.function_name}"
  role              = "${var.role}"
  handler           = "${var.handler}"
  s3_bucket         = "${var.s3_bucket}"
  s3_key            = "${var.s3_key}"
 #s3_object_version = "${var.s3_object_version}"
  source_code_hash  = "${var.source_code_hash}"
  timeout           = "${var.timeout}"
  memory_size       = "${var.memory_size}"
  layers            = ["${var.layer_arn}"]

  environment = ["${slice( list(var.environment), 0, length(var.environment) == 0 ? 0 : 1 )}"]

  vpc_config {
    #vpc_id             = "${var.vpc_id}"
    subnet_ids         = ["${var.subnet_ids}"]
    security_group_ids = ["${var.security_group_ids}"]
  }
}

resource "aws_lambda_layer_version" "lambda_layer" {
  s3_bucket            = "${var.s3_bucket}"
  s3_key               = "${var.s3_key_layer}"
  layer_name           = "${var.layer_name}"
  compatible_runtimes  = ["${var.layer_runtimes}"]
}
