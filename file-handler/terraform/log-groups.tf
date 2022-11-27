resource "aws_cloudwatch_log_group" "lambda_file_handler_logging" {
  name              = "/aws/lambda/${aws_lambda_function.file_handler.function_name}"
  retention_in_days = 3
}
