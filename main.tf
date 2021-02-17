terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    docker = {
      source = "kreuzwerker/docker"
    }
  }
}

provider "aws" {
  profile                 = "default"
  region                  = "us-east-1"
  shared_credentials_file = "credentials"
}

provider "docker" {

}


// AWS Resources
resource "aws_s3_bucket" "tf_course" {
  bucket = "tf-course-20210207"
  acl    = "private"
}




data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.web.public_ip} >> private_ips.txt"

  }

  tags = {
    Name = "DevOps_Cohort_2020"
  }
}
/*
resource "aws_eip" "ip" {
  vpc      = true
  instance = aws_instance.web.id
}
*/

// Docker Resources
resource "docker_image" "nginx" {
  name         = "nginx:latest"
  keep_locally = false
}

resource "docker_container" "nginx" {
  image = docker_image.nginx.latest
  name  = "tutorial"
  ports {
    internal = 80
    external = 8000
  }
}

