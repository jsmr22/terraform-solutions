# GCP Project with Terraform

This Terraform project automates the creation of infrastructure based on the architecture diagram for your project on Google Cloud Platform (GCP).

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
./script.sh init specs/specs.tfvars
```

- Initialize Terraform.
- Configure the GCP project.
- Enable the necessary APIs for the project on GCP.

### Plan the Project

To get a preview of the changes that Terraform will apply, generate a plan for the infrastructure.

```bash
./script.sh plan specs/specs.tfvars
```

### Apply the Infrastructure

To create the infrastructure, apply the configuration, which will deploy the resources defined in your Terraform setup.
```bash
./script.sh apply specs/specs.tfvars
```

### Destroy the Infrastructure

If you need to remove the infrastructure, destroy the resources, which will remove all resources created by Terraform.
```bash
./script.sh destroy specs/specs.tfvars
```

## Author 🐒

* Javier Sainz Maza
