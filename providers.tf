##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
    region = "ap-southeast-1"
}

provider "http" {}

provider "random" {}

provider "cloudinit" {}