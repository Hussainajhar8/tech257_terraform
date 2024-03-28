terraform {
  required_providers {
    github = {
      source = "integrations/github"
      version = "6.2.1"
    }
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "github" {
  token = var.github_token
  # Configuration options
}

resource "github_repository" "multi_provider_terraform" {
  name        = var.github_name

  visibility = var.github_visibility

}

provider "aws" {
  region = var.aws_region # This is where the resources will be created
}

# This is the resource that will be created in this case an instance
resource "aws_instance" "tech257_ajhar_terraform_app" { 
  ami                         = var.app_ami_id # This is the AMI for the instance
  instance_type               = var.app_instance_type # This is the type of instance
  associate_public_ip_address = true # This will assign a public IP to the instance
  key_name                    = var.key_name # This is the key pair that will be used to access the instance
  security_groups             = [aws_security_group.tech257_ajhar_terraform_sg.name] # This is the security group that will be attached to the instance
  tags = {
    Name                      = var.instance_name # This is the name of the instance
  }
}

resource "aws_security_group" "tech257_ajhar_terraform_sg" {
  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = ingress.value["cidr_blocks"]
    }
  }

  tags = {
    Name = var.sg_name
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tech257_ajhar_terraform_sg.id
  cidr_ipv4         = var.egress_cidr_ipv4
  ip_protocol       = var.egress_ip_protocol # semantically equivalent to all ports
}
