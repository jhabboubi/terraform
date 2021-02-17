# Terraform


- [Terraform](#terraform)
  - [Requirements](#requirements)
  - [Infrastructure as code (IaC)](#infrastructure-as-code-iac)
  - [What is Terraform?](#what-is-terraform)
  - [Terraform vs. Chef, Puppet, etc.](#terraform-vs-chef-puppet-etc)
  - [Installing Terraform - Windows](#installing-terraform---windows)
  - [Installing Terraform - Linux](#installing-terraform---linux)
  - [Create AWS IAM use](#create-aws-iam-use)
  - [Creating credentials file](#creating-credentials-file)
  - [Git init & terraform init](#git-init--terraform-init)
  - [Format and validate the configuration](#format-and-validate-the-configuration)
  - [Logging for Terraform](#logging-for-terraform)
  - [Terraform apply](#terraform-apply)
  - [Terraform plan](#terraform-plan)
  - [Terraform state](#terraform-state)
  - [Terraform graph](#terraform-graph)
  - [Terraform Resources](#terraform-resources)
  - [Terraform Variables](#terraform-variables)
  - [Terraform Provisioner](#terraform-provisioner)
  - [Links](#links)
  - [Challenges & Workarounds](#challenges--workarounds)


## Requirements
- [AWS Account](https://aws.amazon.com/account/)
- Git
- Basics in System administration and networking basics
- `terraform [command] -help`   **syntax for a command**

## Infrastructure as code (IaC)
- [Introduction to Infrastructure as Code with Terraform](https://learn.hashicorp.com/tutorials/terraform/infrastructure-as-code?in=terraform/aws-get-started)
- Advantages of Infrastructure as code
  - Easily Repeatable
  - Easily Readable
  - Operational certainty with "terraform plan"
  - Standardized environment builds
  - Quickly provisioned development environment
  - Disaster Recovery

## What is Terraform?
- Terraform is a tool for building, changing, and versioning infrastructure safely and efficiently. Terraform can manage existing and popular service providers as well as custom in-house solutions.
- Infrastructure management tool made by [HashiCorp](https://www.hashicorp.com) or open-source infrastructure as code software tool
- Provision, manage, and maintain cloud resources like servers, networking, storage. 
- Terraform is for managing the base infrastructure *Not a configuration Management System*
- Terraform works with Docker, Kubernetes, Cloud. 
- Terraform presently supports more than 70 providers.

![terraformflow](/assets/terraformflow.png)  
![terraform-context-model-illustration](/assets/terraform-context-model-illustration.png)
![terraform-ansible](/assets/terraform-ansible.png)


## Terraform vs. Chef, Puppet, etc.
Configuration management tools install and manage software on a machine that already exists. Terraform is not a configuration management tool, and it allows existing tooling to focus on their strengths: bootstrapping and initializing resources.

Terraform focuses on the higher-level abstraction of the datacenter and associated services, while allowing you to use configuration management tools on individual systems. It also aims to bring the same benefits of codification of your system configuration to infrastructure management.

If you are using traditional configuration management within your compute instances, you can use Terraform to configure bootstrapping software like cloud-init to activate your configuration management software on first system boot.


## Installing Terraform - Windows
- Visit [Terraform Download CLI](https://www.terraform.io/downloads.html) > choose the operating system.
- Choose folder to download in `%USERPROFILE%\bin`    *create bin folder if not available*
- Extract the file into `%USERPROFILE%\bin`
- Search for `Environment Variable` on your machine > click `Environment Variables...` on User variables for "your-user" highlight `Path` click `New` type into the field `%USERPROFILE%\bin` click `OK` then `OK` then `OK` to exit Environment Variables.
- Open a new PowerShell and type `terraform` to check if Terraform was inserted into your Path correctly. 

![installing_terraform_windows](/assets/installing_terraform_windows.gif)
Visit [Install Terraform Documentation](https://learn.hashicorp.com/tutorials/terraform/install-cli) 


## Installing Terraform - Linux
- `wget https://releases.hashicorp.com/terraform/0.14.6/terraform_0.14.6_linux_amd64.zip`   *64-bit*  [Terraform Download CLI](https://www.terraform.io/downloads.html)
- `unzip terraform_0.14.6_linux_amd64.zip`
- `sudo mv terraform /bin`
- `rm terraform_0.14.6_linux_amd64.zip`
- `terraform --version`


## Create AWS IAM use
- Login to [AWS Account](https://aws.amazon.com/account/)
- Click `Users` on Dashboard then `Add user`
- Insert a username. Example `terraform`
-  Select AWS access type `Programmatic access`
-  Go next select `Attach existing policies directly` then check `AdministratorAccess`  *this is bad practice and should be avoided if you know what policies to assign your username to use terraform*
-  Click Next and Review
-  Download the .CSV file containing the credentials


## Creating credentials file
- Open credential file from previous step and edit using vscode
- Delete the first line containing headings
- Delete username comma and password field
- Delete the website at the end
- Add `[default]` at the beginning of the file
- Add before Access key ID `aws_access_key_id=`
- Add before Secret access key `aws_secret_access_key=`
- Save in `%USERPROFILE%\.aws\credentials`    *credentials file has no extension so make sure it don't have via the command line*
![credentials example](/assets/credentails.png)
- `mv new_user_credentials.csv credentials`  
  
![credentialsfile](/assets/credentialsfile.png)


## Git init & terraform init
- Open GitBash and type command `mkdir ~/Desktop/terraform`
- `cd ~/Desktop/terraform` then init git by `git init`
- Create file first_code.tf by command `vim first_code.tf`
![first_code](/assets/first_code.png)
- To change the default location of the credentials file use `shared_credentials_file = "credentials path"` beneath `region = "us-west-2"` in `first_code.tf` file
- Add terraform to .gitignore (Important security measurement) 
    - .gitignore can be downloaded or forked from this repo
    - Contains windows/linux/mac/terraform
    - Create your own via [Toptal](https://www.toptal.com/developers/gitignore)
- `git add *` then `git commit -m "init commit and config file"`
- `terraform init`  
![terraform_init](/assets/terraform_init.png)
- `git push`


## Format and validate the configuration
- The `terraform fmt` command automatically updates configurations in the current directory for easy readability and consistency.
- Terraform will return the names of the files it formatted. In the case, your configuration file was already formatted correctly, Terraform won't return any file names.
- the built in `terraform validate` command will check and report errors within modules, attribute names, and value types.


## Logging for Terraform
[Instructions for Windows & Linux](https://www.phillipsj.net/posts/how-to-configure-logging-for-terraform/)


## Terraform apply
- Executing `terraform apply` will generate a plan and prompt to execute.
![commandline](/assets/terraformapply.png)
![amazon_account](/assets/amazonterraformapply.png)
- `terraform apply filename.plan` will apply without prompting yes/no **assumes you have already revised the plan**
- `terraform apply -auto-approve`  generate plan, apply plan without prompting yes/no **use at your own risk**


## Terraform plan
- Will execute automatically if `terraform apply` executed
- Plan will show each step that will be executed
- Will check the state between your configurations and real physical resources  
![terraform plan](/assets/terraformplan.png)
![terraform plan to destroy](/assets/terraformplandestroy.png)
- Use [option] `-out=filename.plan` to generate plan and save it to a file, otherwise the plan generated might not be the same when getting to apply stage. 
- To inspect the plan `terraform show filename.plan`  
`cat filename.plan` don't work since it's a binary file 


## Terraform state
![terraformexecution](/assets/terraformexecutionplan.png)  

- `cat terraform.tfstate` this will show json information about the local state\ ** local state and remote state might be out of sync until terraform pull the state from the infrastructure **
- The file may include sensitive information therefore, the need to make sure to include the `.tfstate` extension in `.gitignore` file is necessary in order to disable git pushing to a public github 
- Below is a screenshot from [Terraform Documentation](https://www.terraform.io/docs/language/state/remote.html)
- Remote State is part of a feature on Terraform call `Backends` [Read more about Backends here](https://www.terraform.io/docs/language/settings/backends/index.html)
![terraformremote](/assets/terrafromremote.png)
- `terraform state`  has a two handy subcommands `list` that shows a list of resources and  `show [resource]` shows a specific resource. `terraform show`  will dump all resources state. 


## Terraform graph
- Terraform builds a graph part of the plan and can be exported then rendered visually. 
- `terraform graph`  **the syntax of the output is DOT**  
![terraformgraph](/assets/terraformgraph.png)
![DOT](/assets/DOT.png)

- Visualizing DOT require a graph visualizer. Ex: [http://webgraphviz.com](http://webgraphviz.com)
![vizgraph](/assets/graphviz.png)

[Read More On Graphs Here](https://www.terraform.io/docs/cli/commands/graph.html)


## Terraform Resources 
- Building blocks of Terraform
- Define the "what" of your infrastructure
- Different settings for every provider

[Required Providers](https://www.terraform.io/docs/language/providers/requirements.html)
[Providers](https://registry.terraform.io/browse/providers)


## Terraform Variables
- [Input/output/local variables](https://www.terraform.io/docs/language/values/variables.html)
- [Video](https://learn.hashicorp.com/tutorials/terraform/aws-variables?in=terraform/aws-get-started)


## Terraform Provisioner
- [Provisioners](https://www.terraform.io/docs/language/resources/provisioners/syntax.html)


## Links
- [SaaS vs PaaS vs IaaS: What’s The Difference & How To Choose](https://www.bmc.com/blogs/saas-vs-paas-vs-iaas-whats-the-difference-and-how-to-choose/)
- [Terraform deprecated the Chef Provisioner in the 0.13.4 release](https://docs.chef.io/terraform/)
- [Terraform Cheat Sheet](https://jayendrapatil.com/terraform-cheat-sheet/)
- [Ansible and HashiCorp: Better Together](https://www.hashicorp.com/resources/ansible-terraform-better-together) [github used in video](https://github.com/scarolan/ansible-terraform)
- [Manage Kubernetes Resources via Terraform](https://learn.hashicorp.com/tutorials/terraform/kubernetes-provider?in=terraform/kubernetes)


## Challenges & Workarounds
If `terraform validate` was successful and your apply still failed, you may be encountering a common error.

- **If you use a region other than** `us-east-1`, you will also need to change your `ami`, since AMI IDs are region specific. Choose an AMI ID specific to your region by [following these instructions](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/finding-an-ami.html#finding-quick-start-ami), and modify `*.tf` with this ID. Then re-run `terraform apply`.

- **If you do not have a default VPC in your AWS account in the correct region**, navigate to the AWS VPC Dashboard in the web UI, create a new VPC in your region, and associate a subnet and security group to that VPC. Then add the security group ID (`vpc_security_group_ids`) and subnet ID (`subnet_id`) into your `aws_instance` resource, and replace the values with the ones from your new security group and subnet.
![vpc_correct_region](/assets/VPC_correct_region.png)
Save the changes to `*.tf`, and re-run `terraform apply`. [full article here](https://learn.hashicorp.com/tutorials/terraform/aws-build?in=terraform/aws-get-started)

