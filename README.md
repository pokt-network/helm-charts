# Pocket Network Protocol helm-charts <!-- omit in toc -->

![Static Badge](https://img.shields.io/badge/Maintained_by-Grove-green)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues/pokt-network/helm-charts)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-pr/pokt-network/helm-charts)
![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-closed/pokt-network/helm-charts)

## Table of Contents <!-- omit in toc -->

- [Introduction](#introduction)
  - [Getting started](#getting-started)
  - [Makefile targets](#makefile-targets)
  - [Required packages](#required-packages)
- [Releasing a New Version](#releasing-a-new-version)
  - [Versioning](#versioning)
  - [Updates to the `main` Branch](#updates-to-the-main-branch)
  - [Important Considerations on Multiple Updates](#important-considerations-on-multiple-updates)
- [ClaudeSync Setup](#claudesync-setup)

## Introduction

Welcome to Pocket Network's helm repo. Here you'll find the charts to get Path up and running.

### Getting started

To add Pocket Network's helm repository to your local machine, run the following command:

```sh
helm repo add pocket https://pokt-network.github.io/helm-charts
```

Once you have the repository added, refresh the repositories added running:

```sh
helm repo update
```

### Makefile targets

This repository has a number of makefile targets which allow the team with functionality such as validations and workflow execution.

If you're unsure where to start, run `make help` for a better understanding of the target capabilities.

### Required packages

This repo requires you to have installed the following packages:

- `helm`
- `gh`

To install them using Homebrew simply run the following command:

```sh
brew install helm gh
```

If you're using a distribution other than MacOS or not using Homebrew, head over to the release page of each package to find out the best way to install them:

- https://helm.sh/docs/intro/install/
- https://github.com/cli/cli?tab=readme-ov-file#installation

## Releasing a New Version

### Versioning

When the Helm chart is prepared for release, update its version in the `Chart.yaml` file.

Adhere to [SemVer](https://semver.org/) guidelines for versioning.

### Updates to the `main` Branch

Upon updating the version in the `main` branch, the CI will automatically create a new release for the Helm chart.

## ClaudeSync Setup

This repo is setup to use [ClaudeSync](https://github.com/jahwag/ClaudeSync) to help answer questions about the repo.

You can view `.claudeignore` to see what files are being ignored to ensure Claude's context is limit to the right details.

1. **Install ClaudeSync** - Ensure you have python set up on your machine

   ```shell
   pip install claudesync
   ```

1. **Authenticate** - Follow the instructions in your terminal

   ```shell
   claudesync auth login
   ```

1. **Create a Project** - Follow the instructions in your terminal

   ```shell
   make claudesync_init
   ```

1. **Start Syncing** - Run this every time you want to sync your local changes with Claude

   ```shell
   make claudesync_push
   ```

1. **Set the following system prompt**

   ```text
   You are a friendly, helpful AI assistant specialized in analyzing Helm charts and Kubernetes configurations.

   Your task is to review Helm charts, explain issues in simple terms, and provide straightforward recommendations.

   When reviewing Helm charts:

   1. Focus on critical issues first - what's preventing deployment or causing errors
   2. Explain problems and solutions in plain language a backend developer would understand
   3. Provide specific, actionable fixes with code examples when helpful
   4. Keep explanations brief and bias to using bullet points for clarity

   Present your findings in a conversational way:
   - Start with a brief overall assessment (1-2 sentences)
   - List 3-5 key issues/recommendations as bullet points
   - Offer code snippets only for the most important fixes
   - End with a simple "next steps" suggestion
   - Bias towards industry best practices

   Avoid:
   - Lengthy analysis processes
   - DevOps jargon without explanation
   - Complex Kubernetes concepts without context
   - Overwhelming the user with too many recommendations
   - Giving multiple solutions unless you're asked for them

   Remember that while the user is an experienced engineer, and they are not professional DevOps.
   It is likely they may not be familiar with Kubernetes or Helm chart best practices, so focus on practical solutions rather than theoretical correctness.
   ```
