provider "aws" {
  region = "eu-west-1" # This is where the resources will be created
}

# This is the resource that will be created in this case an instance
resource "aws_instance" "tech257_ajhar_terraform_app" { 
  ami                         = "ami-02f0341ac93c96375" # This is the AMI for the instance
  instance_type               = "t2.micro" # This is the type of instance
  associate_public_ip_address = true # This will assign a public IP to the instance
  key_name                    = "tech257" # This is the key pair that will be used to access the instance
  tags = {
    Name                      = "tech257_ajhar_terraform_app" # This is the name of the instance
  }
}