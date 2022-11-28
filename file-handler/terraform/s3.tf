resource "aws_s3_bucket" "file" {
  bucket        = "${local.environment}-files"
  force_destroy = true
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.file.id

  queue {
    queue_arn = aws_sqs_queue.file.arn
    events    = ["s3:ObjectCreated:*"]
  }
}
