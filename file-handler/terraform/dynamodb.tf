resource "aws_dynamodb_table" "files" {
  name           = "${local.environment}-files"
  billing_mode   = "PROVISIONED"
  read_capacity  = 3
  write_capacity = 3
  hash_key       = "Id"
  range_key      = "CreatedAt"

  attribute {
    name = "Id"
    type = "S"
  }

  attribute {
    name = "CreatedAt"
    type = "N"
  }
}
