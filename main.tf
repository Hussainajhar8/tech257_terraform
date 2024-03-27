provider "aws" {
  region = "eu-west-1" # This is where the resources will be created
}

# This is the resource that will be created in this case an instance
resource "aws_instance" "tech257_ajhar_terraform_app" { 
  ami                         = "ami-02f0341ac93c96375" # This is the AMI for the instance
  instance_type               = "t2.micro" # This is the type of instance
  associate_public_ip_address = true # This will assign a public IP to the instance
  key_name                    = "tech257" # This is the key pair that will be used to access the instance
  security_groups             = [aws_security_group.tech257_ajhar_terraform_sg.name] # This is the security group that will be attached to the instance
  tags = {
    Name                      = "tech257_ajhar_terraform_app" # This is the name of the instance
  }
}

resource "aws_security_group" "tech257_ajhar_terraform_sg" {
  name        = "tech257_ajhar_terraform_sg"
  description = "Allow inbound traffic on port 80 and 22 and 3000"
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
    Name = "tech57_ajhar_terraform_sg"
  }
}

variable "ingress_rules" {
  type = map(any)
  default = {
    # allow all inbound traffic on port 80
    rule1 = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # allow all inbound traffic on port 22
    rule2 = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
    # allow all inbound traffic on port 3000
    rule3 = {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.tech257_ajhar_terraform_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
