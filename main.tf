module "mount-kvv2" {
  source  = "app.terraform.io/HashiCorp_AWS_Org/vault-mount-kvv2/vault"
  version = "1.0.0"
  path    = var.path
}

module "sync_destination" {
  source   = "app.terraform.io/HashiCorp_AWS_Org/secret-sync-destination/vault"
  version  = "1.0.1"
  name     = var.name
  env      = var.env
  role_arn = data.aws_iam_role.aws-vault-role.arn
  mount    = module.mount-kvv2.path
  mount_id = module.mount-kvv2.id
}



module "vault_policy" {
  source  = "app.terraform.io/HashiCorp_AWS_Org/vault-policy/vault"
  version = "2.0.0"
  name    = var.name
  env     = var.env
  policy  = local.vault_policy
}
