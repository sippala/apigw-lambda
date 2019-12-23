output "api_http_method" {
  value = "${aws_api_gateway_method.api_method.http_method}"
}

output "invoke_url" {
  value = "${aws_api_gateway_deployment.api_deployment.invoke_url}"
}
