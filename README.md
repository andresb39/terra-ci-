# Terraform CI/CD GitHub Action

## Overview

This repository provides a **GitHub Action** to automate Terraform workflows, including **formatting, initialization, validation, planning, and applying infrastructure changes**. It ensures that Terraform operations run efficiently and integrates seamlessly with **GitHub pull requests**, adding comments with `terraform plan` results.

## Features

- ✅ **Automatic execution of Terraform commands** (`fmt`, `init`, `validate`, `plan`, `apply`)
- ✅ **Pre-requisites check**: Ensures `tfenv` and `jq` are installed
- ✅ **Identifies modified Terraform directories** and runs commands only where necessary
- ✅ **Posts `terraform plan` results as comments on pull requests**
- ✅ **Removes outdated PR comments** to keep discussions clean and relevant

## Repository Structure

```
├── .github/workflows/   # GitHub Actions workflows
├── cmd/
│   ├── pre-requirements.sh  # Ensures dependencies like tfenv & jq are installed
│   ├── terraform.sh         # Core script executing Terraform commands & PR comments
├── action.yaml          # Defines the GitHub Action for Terraform automation
```

## How It Works

1. **Pre-requisite Check**:

   - The `pre-requirements.sh` script verifies that `tfenv` (Terraform version manager) and `jq` (JSON processor) are installed. If missing, it installs them.

2. **Terraform Execution**:

   - The `terraform.sh` script automatically identifies modified Terraform directories and runs the appropriate Terraform commands.

3. **GitHub Pull Request Integration**:
   - If a **PR is opened**, the action runs `terraform plan` and posts the results as a **comment on the PR**.
   - If a previous plan comment exists, it is **deleted and replaced** with the latest results.

## Usage

To use this GitHub Action in your repository, create a workflow file like this:

```yaml
name: "Terraform CI/CD"

on:
  pull_request:
    branches:
      - main
  push:
    branches:
      - main

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Run Terraform
        uses: andresb39/tf-orchestrator@v1
        with:
          arg: plan
```

## Environment Variables

| Variable                 | Description                                                             |
| ------------------------ | ----------------------------------------------------------------------- |
| `GITHUB_TOKEN`           | Required for posting comments on PRs                                    |
| `GITHUB_EVENT_PATH`      | Path to GitHub event payload                                            |
| `EXPAND_SUMMARY_DETAILS` | (Optional) Expand PR summary details (default: true)                    |
| `HIGHLIGHT_CHANGES`      | (Optional) Highlight changes in `terraform plan` output (default: true) |

## Authors

This action was developed by **@andresb39, @AnthonyMYCD, and @YesMCD** at **myCloudDoor** (January 2025). 🚀
