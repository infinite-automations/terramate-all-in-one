generate_hcl "_terramate_generated_versions.tf" {
  content {
    terraform {
      required_version = global.terraform_version
      required_providers {
        null = {
          source  = "hashicorp/null"
          version = global.terraform_null_provider_version
        }
      }
    }
  }
}