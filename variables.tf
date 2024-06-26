##################################################################################
# VARIABLES
##################################################################################

variable "public_key" {
  type    = string
  default = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICd8MjhHwvOszxaFSd2hAwXSQTGLJRxKkiAlvIdk1WBy eddsa-key-20240603"
}

variable "key_pair_name" {
  type    = string
  default = "tsanghan-ce6-tofu"
}