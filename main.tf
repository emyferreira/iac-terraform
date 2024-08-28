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

resource "aws_instance" "ec2-iac-aula2" { // bloco de armazenamento (disco)
  ami = "ami-066784287e358dad1"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-iac-aula2"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 30
    volume_type = "gp3"
  }

  security_groups = [aws_security_group.sg_aula_iac.name, "default"] // associando aos grupos de segurança
  // normalmente juntamos mais de um grupo de segurança, nesse caso o default tem menor preferência

  key_name = "aula_iac"

  // caso queira indicar uma subnet da aWS
  // subnet_id = "subnet-04d21f6c9df0a7836" // subnet padrão da região us-east-1

  // caso queira indicar uma subnet criada em arquivos .tf (usar esse no projeto)
  subnet_id = aws_subnet.minha_subrede.is
}

variable "porta_http" {
  description = "porta http"
  default = 80
  type = number
}

variable "porta_https" {
  description = "porta https"
  default = 443
  type = number
}


resource "aws_security_group" "sg_aula_iac" {
  name = "sg_aula_iac"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = var.porta_http
    to_port     = var.porta_http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  } // não sei se essa parte de ingress e egress ta certa

  egress {
    from_port   = var.porta_http
    to_port     = var.porta_http
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    ingress {
    from_port   = var.porta_https
    to_port     = var.porta_https
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = var.porta_https
    to_port     = var.porta_https
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_subnet" "minha_subrede" {
  vpc_id = "id da VPC"
  cidr_block = "10.10.10.0/24"
}