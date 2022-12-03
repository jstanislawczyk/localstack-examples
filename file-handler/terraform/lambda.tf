resource "aws_lambda_function" "file_handler" {
  filename      = "file-handler.zip"
  function_name = "${local.environment}-file-handler"
  role          = aws_iam_role.lambda_file_handler_role.arn
  handler       = "index.handler"
  runtime       = "nodejs14.x"
  timeout       = 5

  source_code_hash = filebase64sha256("file-handler.zip")

  environment {
    variables = {
      DYNAMO_DB_TABLE_NAME = aws_dynamodb_table.files.name
    }
  }
}

resource "aws_lambda_event_source_mapping" "file_handler_sqs_mapping" {
  event_source_arn       = aws_sqs_queue.file.arn
  function_name          = aws_lambda_function.file_handler.arn
  batch_size             = 1
  maximum_retry_attempts = 1
}
