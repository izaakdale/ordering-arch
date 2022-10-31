data "aws_iam_policy_document" "dynamo_oidc_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:default:aws-dynamo"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_role" "dynamo_access_oicd" {
  assume_role_policy = data.aws_iam_policy_document.dynamo_oidc_assume_role_policy.json
  name               = "dynamo-access-oidc"
}

resource "aws_iam_policy" "dynamo_access_policy" {
  name        = "dynamo-all-access-policy"
  path        = "/"
  description = "Dynamodb access policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:*",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:eu-west-2:735542962543:table/*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dynamo_all_access_attach" {
  role       = aws_iam_role.dynamo_access_oicd.name
  policy_arn = aws_iam_policy.dynamo_access_policy.arn
}

output "dynamo_policy_arn" {
  value = aws_iam_role.dynamo_access_oicd.arn
}