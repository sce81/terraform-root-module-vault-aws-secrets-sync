data "aws_iam_role" "aws-vault-role" {
  name = var.aws_vault_role_name
}

locals {

  aws_iam_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "secretsmanager:DescribeSecret",
            "secretsmanager:GetSecretValue",
            "secretsmanager:CreateSecret",
            "secretsmanager:PutSecretValue",
            "secretsmanager:UpdateSecret",
            "secretsmanager:UpdateSecretVersionStage",
            "secretsmanager:DeleteSecret",
            "secretsmanager:RestoreSecret",
            "secretsmanager:TagResource",
            "secretsmanager:UntagResource"
          ],
          "Resource" : "arn:aws:secretsmanager:*:*:secret:vault*"
        }
      ]
    }
  )

  vault_policy = <<EOT
    # Allow full access to the sync feature
    path "sys/sync/*" {
      capabilities = ["read", "list", "create", "update", "delete"]
    }

    # Allow read access to the secret mount path/to
    path "path/to/*" {
      capabilities = ["read"]
    }

    # Deny access to a specific secret
    path "path/to/data/my-secret-1" {
      capabilities = ["deny"]
    }
EOT


  # Convert null → "" safely
  common_tags_str = try(tostring(var.common_tags), "")
  extra_tags_str  = try(tostring(var.extra_tags), "")

  # Only split when non-empty
  input_list = concat(
    local.common_tags_str != "" ? split(", ", local.common_tags_str) : [],
    local.extra_tags_str != "" ? split(", ", local.extra_tags_str) : []
  )

  tags = {
    for pair in local.input_list :
    split("=", pair)[0] => split("=", pair)[1]
  }

}