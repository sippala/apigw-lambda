//Lambda Variables
variable "function_name"      { default = "Test-apigw-lambda" }
variable "lambda_description" { default = "Lambda that gets triggered by APIGateway" }
variable "runtime"            { default = "python3.6" }
variable "s3_key"             { default = "test/lambda/lambda.zip" }
variable "lambda_handler"     { default = "lambda_function.lambda_handler" }
variable "timeout"            { default = "300" } 
variable "memory_size"        { default = "512" } 
variable "lambda_file"        { default = "lambda.zip" }

variable "s3_key_layer"       { default = "test/lambda/lambda_layer.zip" }
variable "layer_name"         { default = "test_layer" }
variable "layer_runtimes"     { default = "python3.6" }

//VPC
variable "vpc_id"             { default = "" }
variable "subnet_ids"         { 
  type = "list"
  default = [] 
}
variable "security_group_ids" { default =" " }
variable "cloudwatch_sns_arn" { default = "" }

//Lambda Permission
variable "statement_id"       { default = "AllowApiGateway" }
variable "action"             { default = "lambda:InvokeFunction" }
variable "principal"          { default = "apigateway.amazonaws.com" }
variable "source_arn"         { default = "" }

//Api Gateway
variable "api_name"                   { default = "test-api" }
variable "api_description"            { default = "Rest API for testing" }         
variable "endpoint_type"              { default = "EDGE" }
variable "resource_path"  { default = "shan_test" }
variable "http_method"                { default = "GET" }
variable "authorization"              { default = "NONE" }
variable "integration_type"           { default = "AWS" }
variable "integration_http_method"    { default = "POST" }
variable "uri"                        { default = "" }
variable "pass_behavior"              { default = "WHEN_NO_TEMPLATES" } 

variable "options_http_method"        { default = "OPTIONS" }
variable "options_integration_type"   { default = "MOCK" }
variable "options_pass_behavior"      { default = "WHEN_NO_MATCH" }

//Security Group
variable "security_group_description" { default = "Security Group for Onboarding Lambda" }

variable "ingress"  {
  default = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
       "0.0.0.0/0"
    ]
  }
}                                     

variable "egress" {
  default = {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [
      "0.0.0.0/0"
    ] 
  }
}

variable "region"    {default = "us-west-2"}

variable "tags" {
  description = "A mapping of tags to assign to all resources"
  default     = {}
}

variable "request_parameters" {
  default = { }
}

variable "response_parameters" {
  default =
    {
     "method.response.header.Access-Control-Allow-Origin" = true
    }
}

variable "method_res_params" {
  default =
    {
      "method.response.header.Access-Control-Allow-Headers" = true,
      "method.response.header.Access-Control-Allow-Methods" = true,
      "method.response.header.Access-Control-Allow-Origin"  = true
    }
}

variable "integration_res_params" {
  default =
    {
      "method.response.header.Access-Control-Allow-Headers" = "'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'",
      "method.response.header.Access-Control-Allow-Methods" = "'GET,OPTIONS,POST,PUT'",
      "method.response.header.Access-Control-Allow-Origin" = "'*'"
    }
}

//sns 
variable "cloudwatch_sns_topic"        { default = "apigw-lambda" }

//cloudwatch 
variable "comparison_operator"         { default = "GreaterThanOrEqualToThreshold" }
variable "evaluation_periods"          { default = "1" }
variable "namespace"                   { default = "AWS/Lambda" }
variable "period"                      { default = "300" }
variable "statistic"                   { default = "Average" }
variable "threshold"                   { default = "0" }
variable "treat_missing_data"          { default = "notBreaching" }

variable "lambda_metric_name"          { default = "Errors" }
variable "lambda_namespace"            { default = "AWS/Lambda" }
variable "lambda_alarm_description"    { default = "" }

variable "api5x_metric_name"           { default = "5XXError" }
variable "api_namespace"               { default = "AWS/ApiGateway" }
variable "api5x_alarm_description"     { default = "" }

variable "api4x_metric_name"           { default = "4XXError" }
variable "api4x_alarm_description"     { default = "" } 
