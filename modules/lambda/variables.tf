variable "source_code_hash" {
  default = ""
}

variable "function_name" {
  description = "A unique name for Lambda function"
  type        = "string"
}

variable "runtime" {
  description = "The runtime environment for Lambda function"
  type        = "string"
}

variable "s3_bucket" {}

variable "approle" {
  default = "transform"
}

variable "role" { 
  default = ""
}

variable "aws_account" {
  default = "dev"
}

variable "s3_key"            { }
#variable "s3_object_version" { }

variable "handler" {
  description = "The function entrypoint in your code"
  type        = "string"
}

variable "memory_size" {
  default = ""
}

variable "timeout" {
  description = "The amount of time your Lambda function had to run in seconds"
  default     = ""
}

variable "description" {
  description = "Description of what your Lambda function does"
  type        = "string"
  default     = ""
}

variable "environment" {
  description = "Environment configuration for the Lambda function"
  type        = "map"
  default     = {}
}

variable "account_id" {
  description = "Account ID for role policy"
}

variable "vpc_id" {
  description = "ID of the VPC Lambda is in"
}

variable "subnet_ids" {
  type        = "list"
  description = "Subnets IDs of VPC"
}

variable "security_group_ids" {
  type        = "list"
  description = "Security group id"
}

variable "s3_key_layer" {
  default = "" 
}

variable "layer_name" { 
  default = ""
}

variable "layer_runtimes" { 
  type        = "list"
}

variable "layer_arn" {
  type        = "list"  
}
