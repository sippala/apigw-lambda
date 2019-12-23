resource "aws_iam_role" "role" {
  name               = "${var.function_name}"
  assume_role_policy = "${file("iam_role_policy.json")}"
}

data "template_file" "policy" {
  template = "${file("iam_policy.json")}"
  vars {
    lambda_function_arn  = "arn:aws:lambda:us-west-2:${var.account_id}:function:${var.function_name}"
    bucket_name          = "${var.bucket_name}"
  }
}

resource "aws_iam_policy" "policy" {
  name   = "${var.function_name}-iam-policy"
  policy = "${data.template_file.policy.rendered}"
}

resource "aws_iam_role_policy_attachment" "iam_role_policy_attachment" {
  role       = "${aws_iam_role.role.name}"
  policy_arn = "${aws_iam_policy.policy.arn}"
}
