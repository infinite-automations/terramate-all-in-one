# terramate-all-in-one

[![Test & Release](https://github.com/m4s-b3n/terramate-all-in-one/actions/workflows/test-and-release.yml/badge.svg)](https://github.com/m4s-b3n/terramate-all-in-one/actions/workflows/test-and-release.yml)

Run common terramate commands in a single GitHub action

## Usage

```yaml
name: Terramate Flow

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

permissions:
  contents: read
  pull-requests: write

jobs:
  terramate:
    name: Terramate
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Terramate
        uses: m4s-b3n/terramate-all-in-one@v1.0.3
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}
          apply: ${{ github.event_name != 'pull_request' }}
```

If you want to explicitly separate plan and apply the workflow might look like the following:

```yaml
name: Terramate Flow

on:
  push:
    branches: ["main"]
  pull_request:
    branches: ["main"]

permissions:
  contents: read
  pull-requests: write

jobs:
  plan:
    name: Plan
    runs-on: ubuntu-latest
    if: ${{ github.event_name == 'pull_request' }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Terramate
        uses: m4s-b3n/terramate-all-in-one@v1.0.3
        with:
          github-token: ${{ secrets.GITHUB_TOKEN }}

  apply:
    name: Apply
    runs-on: ubuntu-latest
    if: ${{ github.event_name != 'pull_request' }}
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      - name: Terramate
        uses: m4s-b3n/terramate-all-in-one@v1.0.3
        with:
          apply: true
```

>Note: If you use terramate with a [git config](https://terramate.io/docs/cli/configuration/#terramate-config-git-block-schema) tracking uncommited files add the `terraform-plan-file` and `temp-file` to your `.gitignore` file to prevent errors. See the [default filenames](#inputs) if you do not specify different within your workflow.

## Inputs

| Input | Description | Required | Default |
| --- | --- | --- | --- |
| go-version | The version of Go to use | false | latest |
| terramate-version | The version of Terramate to use (see [releases](https://github.com/terramate-io/terramate/releases)) | false | latest |
| terraform-version | The version of Terraform to use (see [releases](https://github.com/hashicorp/terraform/releases)) | false | latest |
| terramate-args | Arguments to pass to Terramate | false | --changed |
| terraform-common-args | Arguments to pass to Terraform | false |  |
| terraform-init-args | Arguments to pass to Terraform init | false |  |
| terraform-validate-args | Arguments to pass to Terraform validate | false |  |
| terraform-plan-args | Arguments to pass to Terraform plan | false |  |
| terraform-show-args | Arguments to pass to Terraform show | false | -no-color |
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
| comment-pull-request | Comment on pull requests | false | true |
| github-token | GitHub token required for commenting on pull requests | false | `` |
| cleanup | Cleanup temporary files | false | true |

>Note: The `github-token` is not marked as required but it is required when the workflow was triggered by a pull request and commenting on pull requests is enabled.

## Changelog

See the [Changelog](./CHANGELOG.md) file for details
