# Terraform

# Table of Content:
- [Requirements](#requirements)
- [What is Terraform?](#what-is-terraform)
- [Installing Terraform](#installing-terraform)
- [Create AWS IAM use](#create-aws-iam-use)
- [Creating Config file using the credentials csv file](#creating-config-file-using-the-credentials-csv-file)
- [Init git working directory](#init-git-working-directory)


## Requirements
- [AWS Account](https://aws.amazon.com/account/)
- Git
- Basics in System administration and networking basics

## What is Terraform?
- Infrastructure management tool made by [HashiCorp](https://www.hashicorp.com)
- Provision, manage, and maintain cloud resources like servers, networking, storage. 
- Terraform is for managing the base infrastructure *Not a configuration Management System*
- Terraform works with Docker, Kubernetes, Cloud. 
 
## Installing Terraform
- Visit [Terraform Download CLI](https://www.terraform.io/downloads.html) > choose the operating system.
- Choose folder to download in `C:\Users\"youruser"\bin`    *create bin folder if not available*
- Extract the file into `C:\Users\"youruser"\bin`
- Search for `Enviroment Variable` on your machine > click `Environment Variables...` on User variables for "your-user" highlight `Path` click `New` type into the field `%USERPROFILE%\bin` click `OK` then `OK` then `OK` to exit Environment Variables.
- Open a new PowerShell and type `terraform` to check if Terraform was inserted into your Path correctly. 
![installing_terraform_windows](/assets/installing_terraform_windows.gif)
- Visit [Install Terraform Documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli) 

## Create AWS IAM use
- Login to [AWS Account](https://aws.amazon.com/account/)
- Click `Users` on Dashboard then `Add user`
- Insert a username. Example `terraform`
-  Select AWS access type `Programmatic access`
-  Go next select `Attach existing policies directly` then check `AdministratorAccess`  *this is bad practice and should be avoided if you know what policies to assign your username to use terraform*
-  Click Next and Review
-  Download the .CSV file containing the credentials

## Creating Config file using the credentials csv file
- Open credential file from previous step and edit using vscode
- Delete the first line containing headings
- Delete username comma and password field
- Delete the website at the end
- Add `[default]` at the beginning of the file
- Add before Access key ID `aws_access_key_id=`
- Add before Secret access key `aws_secret_access_key=`
- Save as **credentials** into C:\Users\"username"\aws  *credentials file has no extension so make sure it don't have via the command line*
![credentials example](/assets/credentails.png)

## Init git working directory
- Open GitBash and type command `mkdir ~/Desktop/tf_code`
- `cd ~/Desktop/tf_code` then init git by `git init`
- Create file first_code.tf by command `vim first_code.tf`
![first_code](/assets/first_code.png)
- `git add *` then `git commit -m "init commit and config file"` then `git push`
