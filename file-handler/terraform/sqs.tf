resource "aws_sqs_queue" "file" {
  name = "${local.environment}-file"
}
