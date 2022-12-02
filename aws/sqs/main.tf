resource "aws_sqs_queue" "terraform_queue" {
  name                        = "tester-queue.fifo"
  fifo_queue                  = true
  content_based_deduplication = true
}