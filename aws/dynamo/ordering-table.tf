
resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "ordering-app"
  billing_mode   = "PROVISIONED"
  read_capacity  = 20
  write_capacity = 20
  hash_key       = "PK"
  range_key      = "SK"
  ttl {
    enabled = true
    attribute_name = "ttl"
  }

  attribute {
    name = "PK"
    type = "S"
  }

  attribute {
    name = "SK"
    type = "S"
  }
}