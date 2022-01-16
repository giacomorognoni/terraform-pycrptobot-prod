provider "aws" {
  region = var.AWS_REGION
}

# ---------------------------------------------------------------------------------------------------------------------
# SET TERRAFORM RUNTIME REQUIREMENTS
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "giacomo-private"

    workspaces {
      prefix = "pycryptobot-"
    }
  }
}