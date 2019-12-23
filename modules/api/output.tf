output "id" { 
  value = "${aws_api_gateway_rest_api.api.id}"
} 

output "parent_id" {
  value = "${aws_api_gateway_rest_api.api.root_resource_id}"
}
