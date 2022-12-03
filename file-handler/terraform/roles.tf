resource "aws_iam_role" "lambda_file_handler_role" {
  name = "${local.environment}-lambda-file-handler-role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_file_handler_policy_attachment" {
  role       = aws_iam_role.lambda_file_handler_role.name
  policy_arn = aws_iam_policy.lambda_file_handler_policy.arn
}
