module "api" {
  source         = "./modules/api"
  name           = "${local.this_env_prefix}-${var.api_name}"
  description    = "${var.api_description}"
  endpoint_type  = ["${var.endpoint_type}"]
}

module "api_resource" {
  source       = "./modules/api_resource"
  rest_api_id  = "${module.api.id}"
  parent_id    = "${module.api.parent_id}"
  path_part    = "${var.resource_path}"
}

module "api_methods" {
  source                  = "./modules/api_methods"
  rest_api_id             = "${module.api.id}"
  resource_id             = "${module.api_resource.id}"
  http_method             = "${var.http_method}"
  authorization           = "${var.authorization}"
  type                    = "${var.integration_type}"
  integration_http_method = "${var.integration_http_method}"
  stage_name              = "${var.aws-account}"
  pass_behavior           = "${var.pass_behavior}"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${data.aws_caller_identity.current.account_id}:function:${module.lambda.function_name}/invocations"
  response_parameters     = "${var.response_parameters}"
}

module "api_options_method" {
  source                  = "./modules/api_options"
  rest_api_id             = "${module.api.id}"
  resource_id             = "${module.api_resource.id}"
  http_method             = "${var.options_http_method}"
  authorization           = "${var.authorization}"
  type                    = "${var.options_integration_type}"
 #integration_http_method = "${var.opt_integration_http_method}"
  stage_name              = "${var.aws-account}"
  pass_behavior           = "${var.options_pass_behavior}"
  method_res_params       = "${var.method_res_params}"
  integration_res_params  = "${var.integration_res_params}"
}
