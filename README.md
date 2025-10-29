# Secure & Cost-Aware AWS CI/CD Pipeline with Terraform

A professional-grade, end-to-end CI/CD pipeline for deploying AWS infrastructure with built-in security, cost estimation, and governance controls.

![Terraform](https://img.shields.io/badge/Terraform-%237B42BC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23232F3E.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![GitHub Actions](https://img.shields.io/badge/GitHub%20Actions-%232088FF.svg?style=for-the-badge&logo=github-actions&logoColor=white)
![Checkov](https://img.shields.io/badge/Checkov-%2325A0F0.svg?style=for-the-badge&logo=checkov&logoColor=white)
![Infracost](https://img.shields.io/badge/Infracost-%23E11484.svg?style=for-the-badge&logo=infracost&logoColor=white)
![MIT License](https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge)

[![Terraform Apply Status](https://github.com/githubabhay2003/terraform-aws-cicd/actions/workflows/terraform-apply.yml/badge.svg)](https://github.com/githubabhay2003/terraform-aws-cicd/actions/workflows/terraform-apply.yml)

---

## 🚀 Overview

This project demonstrates a fully automated CI/CD pipeline for provisioning, validating, and deploying AWS infrastructure managed with Terraform.

**This project solves the real-world challenge of deploying infrastructure changes safely, securely, and with full cost visibility.** It moves beyond a simple `terraform apply` by integrating "shift-left" principles, embedding security scanning, cost estimation, and manual approval gates directly into the GitOps workflow.

### 🎥 Demo

Here is a short video demonstrating the full CI/CD pipeline in action, from pull request to deployment.

`[Link to Your Demo Video or GIF]`

---

## ⚙️ Architecture & Features

This pipeline is built on a GitOps-centric workflow that triggers two distinct GitHub Actions: one for **Pull Requests** (CI) and one for **Merges to `main`** (CD).

```mermaid
graph TD
    A[Dev creates Pull Request] --> B[GitHub Action: terraform-plan.yml]
    B --> C[Security Scan Checkov]
    B --> D[Cost Estimation Infracost]
    B --> E[Terraform Plan]

    subgraph CI_Workflow[CI Workflow on Pull Request]
        C --> F[Posts SARIF results]
        D --> F
        E --> F[PR Comments for Review]
    end

    F --> G[Team Reviews & Approves PR]
    G --> H[Merge to main]

    H --> I[GitHub Action: terraform-apply.yml]

    subgraph CD_Workflow[CD Workflow on Merge to main]
        I --> J[Wait for Manual Approval]
        J --> K[Terraform Apply]
        K --> L[AWS Infrastructure Deployed]
    end

    %% Colors
    style A fill:#f2f2f2,stroke:#555,stroke-width:1px,color:#000
    style B fill:#fdd835,stroke:#f57f17,stroke-width:2px,color:#000
    style C fill:#ef5350,stroke:#c62828,color:#fff
    style D fill:#42a5f5,stroke:#1565c0,color:#fff
    style E fill:#66bb6a,stroke:#2e7d32,color:#fff
    style F fill:#d1c4e9,stroke:#512da8,color:#000
    style G fill:#ffb74d,stroke:#ef6c00,color:#000
    style H fill:#a1887f,stroke:#5d4037,color:#fff
    style I fill:#fdd835,stroke:#f57f17,color:#000
    style J fill:#90caf9,stroke:#1976d2,color:#000
    style K fill:#81c784,stroke:#388e3c,color:#000
    style L fill:#26a69a,stroke:#004d40,color:#fff
    style CI_Workflow fill:#ede7f6,stroke:#7e57c2,stroke-width:1px,color:#000
    style CD_Workflow fill:#e0f2f1,stroke:#26a69a,stroke-width:1px,color:#000
```
## Key Features

- **Secure OIDC Authentication**: Uses GitHub's OIDC provider to authenticate with AWS via a short-lived IAM Role. No static `AWS_ACCESS_KEY_ID` secrets are required.
- **"Shift-Left" Security**: On every PR, a Checkov scan runs against the Terraform code, uploading any vulnerabilities as SARIF alerts directly to the **Security** tab.
- **Cost Estimation (FinOps)**: On every PR, Infracost runs and posts a comment detailing the estimated monthly cost increase or decrease of the proposed changes.
- **Automated Plan Review**: On every PR, a Terraform plan is generated and posted as a comment, providing a clean execution plan for reviewers.
- **Manual Approval Gate**: Uses GitHub Environments to protect the main branch. A deployment to production requires manual approval from a designated reviewer, preventing accidental applies.
- **Automated Deployment (CD)**: Once approved, the Terraform apply job runs automatically, deploying the infrastructure changes to AWS.
- **Remote State Management**: Utilizes AWS S3 for persistent state storage and DynamoDB for state locking to ensure safe, concurrent operations.

## 📂 Repository Structure

```plaintext
terraform-aws-cicd/
├── .github/
│   └── workflows/
│       ├── terraform-plan.yml  # (CI) Runs checks on Pull Requests
│       └── terraform-apply.yml # (CD) Deploys on merge to main
├── .gitignore
├── backend.tf                  # Configures S3/DynamoDB remote state
├── main.tf                     # Main Terraform code for AWS resources
└── README.md                   # This file
```
## Tech Stack

| Tool | Purpose |
| :--- | :--- |
| **Terraform** | Infrastructure as Code |
| **AWS** | Cloud Provider |
| **GitHub Actions** | CI/CD Automation |
| **GitHub OIDC** | Secure, keyless authentication to AWS |
| **Checkov** | Static Analysis Security Testing (SAST) for IaC |
| **Infracost** | FinOps & Cost Estimation |
| **S3 / DynamoDB** | Terraform Remote State & Locking |
| **Git / GitHub** | Version Control & GitOps |

---

## Setup Instructions (How to Run)

To replicate this project, you will need an AWS account and a GitHub account.

### 1. Fork the Repository

Fork this repo to your own GitHub account.

### 2. AWS Backend Setup

* **S3:** Manually create an S3 bucket with versioning enabled.
* **DynamoDB:** Manually create a DynamoDB table with a partition key named `LockID`.
* Update `backend.tf` with your new bucket name and table name.

### 3. AWS OIDC & IAM Setup

1.  In the AWS IAM console, add **GitHub** as an Identity Provider (OIDC).
2.  Create a new IAM Role that trusts the GitHub OIDC provider (e.g., `token.actions.githubusercontent.com`).
3.  Attach an administrative policy (or a more granular policy) to this role.
4.  Copy the **ARN** of this new role.

### 4. GitHub Secrets & Environments

1.  Go to your forked repo's **Settings > Secrets and variables > Actions**.
2.  Add a new repository secret:
    * `AWS_ROLE_TO_ASSUME`: The ARN of the IAM role you just created.
3.  Get a free Infracost API key by running `infracost register` locally.
4.  Add a second repository secret:
    * `INFRACOST_API_KEY`: Your Infracost API key.
5.  Go to **Settings > Environments** and create a new environment named `production`.
6.  Add a protection rule, select **Required reviewers**, and add your GitHub username.

### 5. Run the Pipeline

1.  Create a new branch:
    ```bash
    git checkout -b feat-test
    ```
2.  Make a small change to `main.tf` (e.g., add an `aws_instance`).
3.  Push the branch and open a Pull Request.
4.  Observe the `plan-and-cost` and `checkov-scan` jobs run.
5.  Merge the PR, navigate to the **Actions** tab, and approve the deployment to see it apply.
