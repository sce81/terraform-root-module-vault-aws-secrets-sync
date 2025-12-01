variable "path" {
  type        = string
  default     = "kvv2"
  description = "friendly name of the vault mount"
}

variable "aws_vault_role_name" {
  type        = string
  default     = "hcp-vault"
  description = "Name of IAM role associated with Vault"
}
variable "extra_tags" {
  type        = string
  default     = ""
  description = "Tags associated with this specific workspace"
}
variable "common_tags" {
  type        = string
  default     = ""
  description = "Tags associated with all workspaces of this type"
}
variable "name" {
  type = string
}
variable "env" {
  type = string
}
variable "region" {
  type        = string
  default     = "eu-west-1"
  description = "AWS Region to deploy resources into"
}