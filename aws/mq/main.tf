resource "aws_mq_broker" "example" {
  broker_name = "example"

  configuration {
    id       = aws_mq_configuration.test.id
    revision = aws_mq_configuration.test.latest_revision
  }

  publicly_accessible = false
  engine_type        = "RabbitMQ"
  engine_version     = "5.15.9"
  host_instance_type = "mq.t2.micro"
#   security_groups    = [aws_security_group.test.id]

  user {
    username = "izaakdale"
    password = "JUSTATESTPASSWORDFORNOW"
  }
}

resource "aws_mq_configuration" "test" {
    id = "helloooooo"
    latest_revision = 1
}