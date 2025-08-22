# GitOps with Flux and Terraform

This repository serves as the source of truth for a GitOps-managed Kubernetes environment powered by [Flux](https://fluxcd.io/) and configured using [Terraform](https://www.terraform.io/). It automates the continuous delivery of Kubernetes workloads through Git-based workflows.

**The main purpose of this project is to demoonstrate the installation of a gitops tool(flux) using iac**
## 📦 Overview

- **GitOps Tool:** [Flux](https://fluxcd.io/)
- **Infrastructure as Code:** [Terraform](https://www.terraform.io/)
- **Deployment Target:** Kubernetes Cluster (using kind)
- **Flux Installation:** Managed via Terraform
- **Repository Role:** Source of truth for Flux to reconcile Kubernetes manifests


## 📁 Structure

```text
.
├── iac/terraform/             # Terraform code to install Flux and configure the cluster
├── clusters/              # Cluster-specific configuration (e.g., overlays)
├── apps/                  # Application manifests (HelmReleases, Kustomizations, etc.)
└── README.md

```

---
**This Documentation was generated with the help of AI**
