terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile                 = "default"
  region                  = "us-east-1"
  shared_credentials_file = "credentials"
}

resource "aws_s3_bucket" "tf_course" {
  bucket = "tf-course-20210207"
  acl    = "private"
}
resource "aws_instance" "example" {
  ami           = "ami-c998b6b2"
  instance_type = "t2.micro"
}