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
