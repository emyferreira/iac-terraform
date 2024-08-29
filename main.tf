terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "ec2-iac-pri-exercicio1" {
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-pri-exercicio1"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
  }

  key_name = "aula_iac"

  subnet_id = aws_subnet.subnet_pri_exercicio1.id

  associate_public_ip_address = false
}

resource "aws_instance" "ec2-iac-pub-exercicio1" {
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-pub-exercicio1"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
  }

  key_name = "aula_iac"

  subnet_id = aws_subnet.subnet_pub_exercicio1.id

  associate_public_ip_address = true
}

resource "aws_subnet" "subnet_pri_exercicio1" {
  vpc_id = "vpc-05494f4a277289424"
  cidr_block = "10.0.2.0/24"

  tags = {
    Name: "subnet_pri",
  }
}

resource "aws_subnet" "subnet_pub_exercicio1" {
  vpc_id = "vpc-05494f4a277289424"
  cidr_block = "10.0.1.0/24"

  map_public_ip_on_launch = true

  tags = {
    Name: "subnet_pub",
  }
}

resource "aws_vpc" "vpc_terraform" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "vpc_terraform"
  } 
}