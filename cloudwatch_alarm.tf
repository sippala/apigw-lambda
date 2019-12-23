data "aws_sns_topic" "sns_topic" { 
  name        = "${local.this_env_prefix}-${var.cloudwatch_sns_topic}"
}

module "cloudwatch_lambda_errors" {
  source                    = "./modules/cloudwatch/"
  alarm_name                = "${local.this_env_prefix}-${var.function_name}-alarm"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "${var.lambda_metric_name}"
  namespace                 = "${var.lambda_namespace}"
  period                    = "${var.period}"
  statistic                 = "${var.statistic}"
  threshold                 = "${var.threshold}"
  alarm_description         = "${var.lambda_alarm_description}"
  treat_missing_data        = "${var.treat_missing_data}"
  dimensions                = {"FunctionName" = "${local.this_env_prefix}-${var.function_name}"}
  alarm_actions             = ["${data.aws_sns_topic.sns_topic.arn}"]  
}

module "cloudwatch_apigateway5xx" {
  source                    = "./modules/cloudwatch/"
  alarm_name                = "${local.this_env_prefix}-${var.api_name}-5xx-alarm"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "${var.api5x_metric_name}"
  namespace                 = "${var.api_namespace}"
  period                    = "${var.period}"
  statistic                 = "${var.statistic}"
  threshold                 = "${var.threshold}"
  alarm_description         = "${var.api5x_alarm_description}"
  treat_missing_data        = "${var.treat_missing_data}"
  dimensions                = {"FunctionName" = "${local.this_env_prefix}-${var.api_name}"}
  alarm_actions             = ["${data.aws_sns_topic.sns_topic.arn}"]
}

module "cloudwatch_apigateway4xx" {
  source                    = "./modules/cloudwatch/"
  alarm_name                = "${local.this_env_prefix}-${var.api_name}-4XX-alarm"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "${var.api4x_metric_name}"
  namespace                 = "${var.api_namespace}"
  period                    = "${var.period}"
  statistic                 = "${var.statistic}"
  threshold                 = "${var.threshold}"
  alarm_description         = "${var.api4x_alarm_description}"
  treat_missing_data        = "${var.treat_missing_data}"
  dimensions                = {"FunctionName" = "${local.this_env_prefix}-${var.api_name}"}
  alarm_actions             = ["${data.aws_sns_topic.sns_topic.arn}"]
}

