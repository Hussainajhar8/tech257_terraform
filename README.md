# Infrastructure as Code (IaC) - Terraform

### What is it
Infrastructure as Code (IaC) means managing and provisioning infrastructure using code instead of manual processes, a common one is Terraform.

### Why should we use it
Using Terraform ensures consistency, scalability, and faster deployments by automating infrastructure setup, this is because once you have the configurations file working you can recreate infrastructure by reusing them which is faster, avoids human error and can be automated further with cicd pipelines.
![alt text](img/image.png)

### When to use it
Use IaC when you need frequent deployments, dynamic environments, or large-scale infrastructure management.

### Where to use it
IaC can be used in cloud environments, on-premises data centers, and containerized environments.

### Tools available for IaC
Popular tools for IaC include Terraform, Ansible, AWS CloudFormation, Azure Resource Manager Templates, and Google Cloud Deployment Manager.

### Who is using IaC in the industry
Companies like Netflix, NASA, Red Hat, Atlassian, and Walmart use IaC for managing infrastructure and automating deployments.

## Pull and Push Configuration Management in IaC

- **Push Configuration**: Configuration changes are actively pushed from a central server to managed nodes, for example with Ansible, you write playbooks defining the desired state, and Ansible pushes these configurations to the nodes to ensure they match the desired state.
- **Pull Configuration**: Managed nodes periodically pull configurations from a central server to converge towards the desired state, for example In SaltStack, you define the desired state in Salt states (SLS files), and the managed nodes pull these states periodically to converge towards the desired state.
![alt text](img/image-13.png)

### Tools supporting Pull/Push
- **Push-based**: Tools like Ansible, Puppet, and Chef predominantly use a push-based approach. Ansible, for example, executes tasks on managed nodes by connecting to them remotely and pushing configurations.
  
- **Pull-based**: Tools like SaltStack and AWS OpsWorks support pull-based configuration management. These tools maintain a centralized repository of configuration states, and managed nodes pull configurations from this repository.

## Desired State vs Current State
- **Desired State**: In configuration management, the desired state refers to how the infrastructure should be configured according to the defined policies, configurations, or playbooks. It represents the ideal configuration that you want your infrastructure to be in.

- **Current State**: The current state is the actual configuration or state of the infrastructure at any given time. It may deviate from the desired state due to manual changes, drift, or other factors.

# Getting Started with Terraform

To begin using Terraform for managing infrastructure on AWS, follow these steps:

1. **Install Terraform:**
   - Download and install Terraform on your local machine.
   - Verify the installation by checking the Terraform version to ensure it's properly installed.
    ![alt text](img/image-1.png)

2. **Configure AWS Access Keys:**
   - Set up your AWS access keys as environment variables on your local machine.
   - ```bash
      export AWS_ACCESS_KEY_ID="your-access-key-id"
      export AWS_SECRET_ACCESS_KEY="your-secret-access-key"
     ```
   - Keep these access keys private and avoid hardcoding in config files or exposing them in public repositories (Keep it far away from any git repositories).

3. **Initialize Terraform:**
   - Navigate to the directory where your Terraform configuration files will reside.
   - Run `terraform init` to initialize the directory as a Terraform workspace.
    ![alt text](img/image-2.png)
   - Select the provider (e.g., AWS) and region where your resources will be deployed.
    ![alt text](img/image-3.png)

4. **Create EC2 Instance:**
   - Define the configuration for the EC2 instance in your Terraform file.
   ![alt text](img/image-4.png)
   - Use Terraform to create a plan with `terraform plan` to review the changes before deployment.
   ![alt text](img/image-5.png)

5. **Deploy Infrastructure:**
   - Execute `terraform apply` to deploy the infrastructure defined in your Terraform configuration.
   - Confirm the plan and proceed with the deployment by entering `yes` when prompted.
   ![alt text](img/image-6.png)
   - After some time our resource is deployed!
   ![alt text](img/image-7.png)

6. **Verify Deployment:**
   - After deployment, verify that the AWS resources are provisioned as expected.
   - Access the AWS Management Console or use AWS CLI commands to check the status of the deployed resources.

7. **Destroy Infrastructure:**
   - When done with the resources, use `terraform destroy` to tear down the infrastructure.
   - Confirm the destruction plan and proceed with the destruction by entering `yes` when prompted.
  ![alt text](img/image-8.png)

By following these steps, we can get a glimpse of how powerful terraform is and see that we can effectively manage infrastructure on AWS using Terraform, allowing for quick provisioning, modification, and destruction of resources.

## Creating Security Group with Terraform

1. **Define Security Group Rules:**
   - Create a Terraform configuration file specifying the rules to allow access on ports 22, 3000, and 80.
   - We should utilize dynamic blocks for improved readability and scalability.
   ![alt text](img/image-9.png)

2. **Add Security Group to Instance Resource:**
   - Associate the created security group with the `aws_instance` resource in your Terraform configuration.
  ![alt text](img/image-10.png)

3. **Apply Terraform Changes:**
   - Run `terraform apply` to apply the changes defined in your Terraform configuration.
   - Verify that the security group is created successfully.
    ![alt text](img/image-11.png)

4. **Confirm Rules Configuration:**
   - Check the AWS Management Console or use AWS CLI commands to confirm that the security group has the intended rules configured.
   - Ensure that port 22 is allowed from all, port 3000 is allowed from all, and port 80 is allowed from all.
    ![alt text](img/image-12.png)

5. **Attach Key Pair and Security Group to EC2:**
   - Confirm that the EC2 instance is launched with the specified key pair and attached security group.
   - Verify that access to the EC2 instance is allowed on ports 22, 3000, and 80 as configured.

