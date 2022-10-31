resource "aws_ecr_repository" "order" {
  name                 = "service-order"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}
resource "aws_ecr_repository" "delivery" {
  name                 = "service-delivery"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}