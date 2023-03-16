resource "aws_ecr_repository" "order" {
  name                 = "service-order"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
resource "aws_ecr_repository" "event" {
  name                 = "service-event"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
resource "aws_ecr_repository" "ticket" {
  name                 = "service-ticket"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}