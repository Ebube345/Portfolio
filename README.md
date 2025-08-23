# 🚀 DevOps & Kubernetes Administrator Portfolio

Hi, I'm **Ebube**, a DevOps and Kubernetes Engineer with hands-on experience building secure, scalable cloud-native infrastructure. I specialize in automation, CI/CD pipelines, cloud networking, and Kubernetes orchestration across AWS, Azure, GCP and On-prem

---

## 🧰 Skills & Tools

### ⚙️ DevOps & Cloud Toolset

| Category                  | Tools |
|---------------------------|-------|
| **CI/CD**                 | GitLab CI, GitHub Actions|
| **Infrastructure as Code**| Terraform, Ansible |
| **Containerization**      | Docker, Kubernetes, Helm |
| **Cloud Platforms**       | AWS, Azure, GCP |
| **Monitoring & Logging**  | Prometheus, Grafana, ELK Stack, CloudWatch |
| **Scripting**             | Python, Bash, PowerShell |
| **Security**              | IAM, Key Vault, Secrets Manager, RBAC |
| **Networking**            | VPC, Private Clusters, DNS, NAT, Firewalls |
| **Databases & Storage**   | RDS, Blob Storage, S3, GCS |

---

## 🧠 Soft Skills & Team Collaboration

As a DevOps professional, I strongly believe that tools are only part of the solution — success comes from great communication, a collaborative mindset, and efficient problem-solving.

### 🧩 Key Soft Skills

- **Cross-Team Collaboration**: Worked closely with development, QA, and security teams to streamline release cycles and improve service uptime.
- **Problem-Solving**: Diagnosed and resolved production incidents, pipeline failures, and performance bottlenecks under pressure.
- **Clear Communication**: Regularly communicated architecture and CI/CD strategies to both technical and non-technical stakeholders.
- **Agile/DevOps Culture**: Participated in daily stand-ups, sprint planning, and incident postmortems.
- **Stakeholder Alignment**: Balanced engineering priorities with business objectives .

---

## 📂 Featured Projects



### Table of Contents

1. [Terraform CI/CD Pipeline](#terraform-cicd-pipeline)
2. [GitOps with Flux and Terraform](#gitops-with-flux-and-terraform)
3. [AWS Import and Sync Resources with Terraform to Enforce Single Source of Truth](#aws-import-and-sync-resources-with-terraform-to-enforce-single-source-of-truth)


---

### Terraform CI/CD Pipeline  
<sub>**Tags:** GitHub Actions, Terraform, CI/CD, Automation, DevOps</sub>

**Location:** [`.github/workflows/terraform.yml`](.github/workflows/terraform.yml)

**Step-by-step:**
1. **Trigger:** Runs on push or pull request to the `main` branch for changes in the Terraform directory (`projects/gitops-with-flux/iac/terraform/`).
2. **Checkout:** Checks out the repository code using `actions/checkout`.
3. **Setup:** Installs the specified Terraform version with `hashicorp/setup-terraform`.
4. **(Optional) Cloud Credentials:** Placeholder for configuring cloud provider credentials (e.g., AWS, Azure, GCP) using OIDC or secrets (commented for customization).
5. **Terraform Init:** Initializes Terraform in the target directory, optionally supporting remote backends.
6. **Terraform Validate:** Validates the Terraform configuration for syntax and best practices.
7. **Terraform Plan:** Generates and outputs a plan (on pull requests) to preview changes before applying.
8. **PR Comment:** (On PRs) Comments the Terraform plan on the pull request for team review using `actions/github-script`.
9. **Terraform Apply:** (On push to main) Applies the Terraform changes automatically with required variables, ensuring infrastructure is updated only after review and merge.

This pipeline ensures infrastructure changes are validated, reviewed, and safely applied using best practices for Infrastructure as Code and GitOps workflows.

---

### GitOps with Flux and Terraform  
<sub>**Tags:** GitOps, Flux, Terraform, Kubernetes, IaC, CI/CD</sub>

**Location:** [`projects/gitops-with-flux/`](projects/gitops-with-flux/)

**Step-by-step:**
1. **GitOps Tool:** Installs [Flux](https://fluxcd.io/) using Terraform, enabling GitOps workflows for Kubernetes.
2. **Infrastructure as Code:** All cluster and app configurations are managed as code in the repo.
3. **Automated Delivery:** Flux continuously reconciles Kubernetes manifests from the repository, ensuring the cluster state matches the desired configuration.
4. **Structure:**
	- `iac/terraform/`: Terraform code for Flux and cluster setup
	- `clusters/`: Cluster-specific overlays
	- `apps/`: Application manifests (HelmReleases, Kustomizations)

---

### AWS Import and Sync Resources with Terraform to Enforce Single Source of Truth 
<sub>**Tags:** Terraform, AWS, Infrastructure as Code, Automation, Bash</sub>

**Location:** [`projects/aws/`](projects/aws/)

Sometimes cloud resources such as Security Groups, EC2, Network Interfaces are created using the console or CLI which makes it difficult to track or delete for existing resources. This terraform project utilizes a modular structure. A module to create a resource group and also another module to import resources and save them into a folder for future reference and import.

**Step-by-step:**
1. **Resource Group Creation:** Uses Terraform modules to create AWS resource groups based on tag filters (`modules/resource_group`).
2. **Resource Import:** Executes a local script (via `null_resource`) to fetch AWS resources (EC2, S3, IAM, Security Groups, VPCs, Subnets, Internet Gateways) and saves their IDs to files in `resource_data/`.
3. **Modular Design:** Organizes logic into modules for resource grouping and importing, making the setup reusable and maintainable.
4. **Configuration:** All variables (region, profile, group name, filters) are set in `variables.tf` for easy customization.

---
