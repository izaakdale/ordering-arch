resource "aws_sns_topic" "order_placed_events" {
  name = "order-placed-events"
}
resource "aws_sqs_queue" "order_placed_queue" {
  name = "order-placed-queue"
  fifo_queue = false
}
resource "aws_sns_topic_subscription" "placed_sub" {
  topic_arn = aws_sns_topic.order_placed_events.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_placed_queue.arn
}

resource "aws_sns_topic" "order_stored_events" {
  name = "order-stored-events"
}
resource "aws_sqs_queue" "order_stored_queue" {
  name = "order-stored-queue"
  fifo_queue = false
}
resource "aws_sns_topic_subscription" "stored_sub" {
  topic_arn = aws_sns_topic.order_stored_events.arn
  protocol  = "sqs"
  endpoint  = aws_sqs_queue.order_stored_queue.arn
}

resource "aws_sqs_queue_policy" "order_placed_queue_policy" {
    queue_url = "${aws_sqs_queue.order_placed_queue.id}"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.order_placed_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.order_placed_events.arn}"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_sqs_queue_policy" "order_stored_queue_policy" {
    queue_url = "${aws_sqs_queue.order_stored_queue.id}"

    policy = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "sqspolicy",
  "Statement": [
    {
      "Sid": "First",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "sqs:SendMessage",
      "Resource": "${aws_sqs_queue.order_stored_queue.arn}",
      "Condition": {
        "ArnEquals": {
          "aws:SourceArn": "${aws_sns_topic.order_stored_events.arn}"
        }
      }
    }
  ]
}
POLICY
}