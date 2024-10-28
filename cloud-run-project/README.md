# Terraform with cloud run

This Terraform project automates the creation of infrastructure that uses cloud run

## 📖 Getting Started

### Requirements

Before you begin, make sure you have the following:

- **Terraform** installed on your machine. You can follow the installation guide [here](https://learn.hashicorp.com/tutorials/terraform/install-cli).
- A **Google Cloud Platform (GCP) account** with the necessary permissions to create and manage resources.

### Setup

1. Set up your GCP project and obtain the **project ID**.

## ✏️ Usage

Follow these steps to deploy the infrastructure using Terraform:

### Initialize the Project

Run the following command to initialize the project, which will:

```bash
./run.sh init environments/dev.tfvars
```

- Initialize Terraform.
- Configure the GCP project.
- Enable the necessary APIs for the project on GCP.

### Plan the Project

To get a preview of the changes that Terraform will apply, generate a plan for the infrastructure.

```bash
./run.sh plan environments/dev.tfvars
```

### Apply the Infrastructure

To create the infrastructure, apply the configuration, which will deploy the resources defined in your Terraform setup.
```bash
./run.sh apply environments/dev.tfvars
```

### Destroy the Infrastructure

If you need to remove the infrastructure, destroy the resources, which will remove all resources created by Terraform.
```bash
./run.sh destroy environments/dev.tfvars
```
