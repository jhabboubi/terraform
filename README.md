# Terraform

## Requirements
---
- [AWS Account](https://aws.amazon.com/account/)
- Git
- Basics in System administration and networking basics

## What is Terraform?
---
- Infrastructure management tool made by [HashiCorp](https://www.hashicorp.com)
- Provision, manage, and maintain cloud resources like servers, networking, storage. 
- Terraform is for managing the base infrastructure *Not a configuration Management System*
- Terraform works with Docker, Kubernetes, Cloud. 
 
## Installing Terraform
---
- Visit [Terraform Download CLI](https://www.terraform.io/downloads.html) > choose the operating system.
- Choose folder to download in `C:\Users\"you-user"\bin`    *create bin folder if not available*
- Extract the file into `C:\Users\"you-user"\bin`
- Search for `Enviroment Variable` on your machine > click `Environment Variables...` on User variables for "your-user" highlight `Path` click `New` type into the field `%USERPROFILE%\bin` click `OK` then `OK` then `OK` to exit Environment Variables.
- Open a new PowerShell and type `terraform` to check if Terraform was inserted into your Path correctly. 