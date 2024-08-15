resource "aws_dynamodb_table" "basic-dynamodb-table" {
  name           = "Customers"
  billing_mode = "PAY_PER_REQUEST"
  hash_key       = "FirstName"
  range_key = "SecondName"

  attribute {
    name = "FirstName"
    type = "S"
  }

  attribute {
    name = "SecondName"
    type = "S"
  }

  tags = {
    Name        = "dynamodb-table-1"
    Environment = "dev"
  }
}