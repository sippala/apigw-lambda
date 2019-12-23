output "api_path" { 
  value = "${aws_api_gateway_resource.resource.path_part}"
}

output "id" {
  value = "${aws_api_gateway_resource.resource.id}"
}
