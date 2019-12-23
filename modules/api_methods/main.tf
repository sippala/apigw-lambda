resource "aws_api_gateway_method" "api_method" {
  rest_api_id   = "${var.rest_api_id}"
  resource_id   = "${var.resource_id}"
  http_method   = "${var.http_method}"
  authorization = "${var.authorization}"

#request_parameters = "${file("querystring.params")}"
#request_parameters = "${var.request_parameters}"
}

resource "aws_api_gateway_method_response" "method_ok" {
  rest_api_id   = "${var.rest_api_id}"
  depends_on    = ["aws_api_gateway_method.api_method"]
  http_method   = "${aws_api_gateway_method.api_method.http_method}"
  resource_id   = "${var.resource_id}"
  status_code   = "200"

  response_models {
    "application/json" = "Empty"
  }

  response_parameters = "${var.response_parameters}"
  depends_on          = ["aws_api_gateway_method.api_method"]
}

resource "aws_api_gateway_integration" "api_integration" {
  rest_api_id             = "${var.rest_api_id}"
  resource_id             = "${var.resource_id}"
  http_method             = "${aws_api_gateway_method.api_method.http_method}"
  type                    = "${var.type}"
  uri                     = "${var.uri}"
  integration_http_method = "${var.integration_http_method}"
  passthrough_behavior    = "${var.pass_behavior}"

  request_templates = {
    "application/json" = "${file("apigw_mapping.template")}"
  }
}

resource "aws_api_gateway_integration_response" "integration_ok" {
  rest_api_id   = "${var.rest_api_id}"
  http_method   = "${aws_api_gateway_method.api_method.http_method}"
  resource_id   = "${var.resource_id}"
  status_code   = "${aws_api_gateway_method_response.method_ok.status_code}"
  depends_on    = ["aws_api_gateway_integration.api_integration"]

  response_templates {
    "application/json" = <<EOF
EOF
  }
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id   = "${var.rest_api_id}"
  stage_name    = "${var.stage_name}"
  depends_on    = [
    "aws_api_gateway_integration.api_integration"
  ]
}
