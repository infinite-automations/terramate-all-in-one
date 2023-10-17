# terramate-all-in-one

Run common terramate commands in a single GitHub action

## Usage

```yaml
name: Terramate
on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

jobs:  
  plan:
    if:
  apply:
```

## Inputs

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| directory | The directory where the Terraform configuration files are located | false | . |
| terramate-version | The version of Terramate to use | false | latest |
| terraform-version | The version of Terraform to use | false | latest |
| terramate-args | Arguments to pass to Terramate | false | --changed |
| terraform-common-args | Arguments to pass to Terraform | false |  |
| terraform-init-args | Arguments to pass to Terraform init | false |  |
| terraform-validate-args | Arguments to pass to Terraform validate | false |  |
| terraform-plan-args | Arguments to pass to Terraform plan | false |  |
| terraform-apply-args | Arguments to pass to Terraform apply | false |  |
| terraform-destroy-args | Arguments to pass to Terraform destroy | false |  |
| terraform-plan-file | Path to Terraform plan file | false | out.tfplan |
| temp-file | Path to preview comment file | false | tmp.txt |
| setup | Setup Terramate and Terraform | false | true |
| init | Initialize Terraform | false | true |
| lint | Run linting | false | true |
| generate | Generate code | false | true |
| validate | Validate Terraform | false | true |
| plan | Plan Terraform | false | true |
| apply | Apply Terraform | false | false |
| destroy | Destroy Terraform | false | false |
| comment-pull-request | Comment on Pull Request | false | true |
| cleanup | Cleanup temporary files | false | true |

## Changelog

See the [Changelog](./CHANGELOG.md) file for details
