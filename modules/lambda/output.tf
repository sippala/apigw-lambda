output "lambda_arn" {
  value = "${aws_lambda_function.function.arn}"
}

output "function_name" { 
  value = "${aws_lambda_function.function.function_name}"
}

output "layer_arn" {
  value = "${aws_lambda_layer_version.lambda_layer.arn}"
}
