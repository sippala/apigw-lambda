resource "aws_api_gateway_method" "options_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.http_method}"
  authorization = "${var.authorization}"
}

resource "aws_api_gateway_method_response" "options_ok" {
  rest_api_id   = "${var.rest_api_id}"
  depends_on    = ["aws_api_gateway_method.options_method"]
  http_method   = "${aws_api_gateway_method.options_method.http_method}"
  resource_id   = "${var.resource_id}"
  status_code   = "200"

  response_models {
    "application/json" = "Empty"
  }
  response_parameters = "${var.method_res_params}"
  depends_on          = ["aws_api_gateway_method.options_method"]
}

resource "aws_api_gateway_integration" "options_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${var.resource_id}"
  http_method             = "${aws_api_gateway_method.options_method.http_method}"
  type                    = "${var.type}"
  uri                     = "${var.uri}"
  #integration_http_method = "${var.integration_http_method}"
  passthrough_behavior    = "${var.pass_behavior}"

  request_templates = {
    "application/json"  =  "${file("apigw_options.template")}"
  }
}

resource "aws_api_gateway_integration_response" "options_ok" {
  rest_api_id   = "${var.rest_api_id}"
  http_method   = "${aws_api_gateway_method.options_method.http_method}"
  resource_id   = "${var.resource_id}"
  status_code   = "${aws_api_gateway_method_response.options_ok.status_code}"
  depends_on    = ["aws_api_gateway_integration.options_integration"]

  response_parameters = "${var.integration_res_params}"

  response_templates {
    "application/json" = <<EOF
EOF
  }
}
