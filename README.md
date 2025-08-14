# terramate-all-in-one

[![Test & Release](https://github.com/infinite-automations/terramate-all-in-one/actions/workflows/test-and-release.yml/badge.svg?branch=main)](https://github.com/infinite-automations/terramate-all-in-one/actions/workflows/test-and-release.yml)

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
        uses: infinite-automations/terramate-all-in-one@v1.2.0
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
        uses: infinite-automations/terramate-all-in-one@v1.2.0
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
        uses: infinite-automations/terramate-all-in-one@v1.2.0
        with:
          apply: true
```

>Note: If you use terramate with a [git config](https://terramate.io/docs/cli/configuration/#terramate-config-git-block-schema) tracking uncommited files add the `terraform-plan-file` and `temp-file` to your `.gitignore` file to prevent errors. See the [default filenames](#inputs) if you do not specify different within your workflow.

## Inputs

| Input Variable               | Description                                           | Required | Default Value |
| ---------------------------- | ----------------------------------------------------- | -------- | ------------- |
| terramate-version            | The version of Terramate to use                       | No       | latest        |
| terraform-version            | The version of Terraform to use                       | No       | latest        |
| terramate-args               | Arguments to pass to each Terramate command           | No       | --changed     |
| terramate-plan-args          | Arguments to pass to Terramate in the plan step       | No       |               |
| terramate-apply-args         | Arguments to pass to Terramate in the apply step      | No       |               |
| terramate-destroy-args       | Arguments to pass to Terramate in the destroy step    | No       | --reverse     |
| terraform-common-args        | Arguments to pass to each Terraform command           | No       |               |
| terraform-init-args          | Arguments to pass to terraform init                   | No       |               |
| terraform-validate-args      | Arguments to pass to terraform validate               | No       |               |
| terraform-plan-args          | Arguments to pass to terraform plan                   | No       |               |
| terraform-show-args          | Arguments to pass to terraform show                   | No       | -no-color     |
| terraform-apply-args         | Arguments to pass to terraform apply                  | No       |               |
| terraform-destroy-args       | Arguments to pass to terraform destroy                | No       |               |
| terraform-plan-file          | Path to Terraform plan file                           | No       | out.tfplan    |
| temp-file                    | Path to preview comment file                          | No       | tmp.txt       |
| setup                        | Setup Terramate and Terraform                         | No       | true          |
| init                         | Initialize Terraform                                  | No       | true          |
| lint                         | Run linting                                           | No       | true          |
| generate                     | Generate code                                         | No       | true          |
| validate                     | Validate Terraform                                    | No       | true          |
| plan                         | Plan Terraform                                        | No       | true          |
| apply                        | Apply Terraform                                       | No       | false         |
| destroy                      | Destroy Terraform                                     | No       | false         |
| comment-pull-request         | Comment on pull requests                              | No       | true          |
| github-token                 | GitHub token required for commenting on pull requests | No       |               |
| cleanup                      | Cleanup temporary files                               | No       | true          |

>Note: The `github-token` is not marked as required but it is required when the workflow was triggered by a pull request and commenting on pull requests is enabled.

## Changelog

See the [Changelog](./CHANGELOG.md) file for details
