resource "aws_sqs_queue" "terraform_queue" {
  name                        = "tester-queue"
  fifo_queue                  = false
  # content_based_deduplication = true
  delay_seconds               = 1
  message_retention_seconds   = 60
}