terraform {
  required_providers {
    kind = {
      source  = "tehcyx/kind"
      version = "0.4.0"
    }
    flux = {
      source  = "fluxcd/flux"
      version = "~> 1.2"
    }
    github = {
      source  = "integrations/github"
      version = "~> 6.2"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
}

provider "kind" {}

provider "github" {
  token = var.github_token
}

# Flux provider will be configured in main.tf after cluster creation