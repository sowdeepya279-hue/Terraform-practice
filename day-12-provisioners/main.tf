terraform {
  required_providers {
    null = {
      source  = "hashicorp/null"
    }
  }
}

provider "null" {}

resource "null_resource" "example" {

  provisioner "local-exec" {
    command = "echo Terraform provisioner executed successfully"
  }
}