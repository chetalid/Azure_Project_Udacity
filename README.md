# Azure Infrastructure Operations Project: Deploying a scalable IaaS web server in Azure
### new line added
### Introduction
This project is for writing a Packer template and a Terraform template to deploy a customizable, scalable web server in Azure. The Packer template allows us to create an image that will allow us to create multiple virtual machines at the same time through Terraform, which will contain all of our infrastructure to be deployed, including: storage, security, and networking configurations.

### Getting Started
1. Create a GIT repository to push your source code.
2. Create Microsoft azure account.
3. Install all the dependencies mentioned in next section.
4. Create your tagging policy in Azure
5. Create resource group in Azure which will be used in every step going forward.

### Dependencies
1. Create an [Azure Account](https://portal.azure.com) 
2. Install the [Azure command line interface](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
3. Install [Packer](https://www.packer.io/downloads)
4. Install [Terraform](https://www.terraform.io/downloads.html)

### Instructions

After the dependencies have been create or installed, it's time to create and deploy the Packer and Terraform templates	

Deploy the Packer Image Template -
Packer deploys virtual machine images which can be used to create multiple virtual machines. Below are the steps -

1. Log into MS Azure

   az login
   
Provide you azure credentials when asked in the browser.

2. Apply policy to require tags for all resources

   az policy definition create --name tagging-policy --rules policy.json --mode indexed --description "require indexed resources to be tagged"
   
   ![tagging-policy-ss](https://user-images.githubusercontent.com/18601050/182711695-00e559a9-b210-402a-ba18-59d0b403628d.PNG)


Note: the policy can be verified to exist with the command mentioned below -

   az policy assignment list

3. Build server image using Packer using below command -

   packer build server.json
   
   ![PackerImage_SS](https://user-images.githubusercontent.com/18601050/182711546-1b2ebe9d-7945-465d-865e-9f183a684d47.PNG)


Note: the image can be verified to exist with the command "az image list"

3. Create infrastructure resources including using Terraform -
Terraform is used to quickly deploy all of our infrastructure, which is listed in the main.tf file, and also utilizes variables in the vars.tf file. The packer image is referenced in the variables section and is used in the template to create our virtual machines.

I have written the terraform code in main.tf which has all the resources details which needs to be created on Azure. Also I have declared variables for all the resources and mentioned their values in var.tf file.

Deploy the Infrastructure with Terraform
To deploy, perform the following steps:

In our Packer image we created a resource group, and we need to import that into Terraform before deploying, so Terraform will used that resource group, instead of trying to create another resource group with the same name, which isn't allowed. To do this we need to run the command terraform import azurerm_resource_group.main /subscriptions/{subsriptionId}/resourceGroups/{resourceGroupName}.
In the Azure CLI run the command terraform plan -out solution.plan to review what infrastructure will be deployed and saved to disk.

Below are the command to initialize the terraform and deploy the infrastructure -:

a) Run 'terraform init' to initialise Terraform
b) Run 'terraform plan -out solution.plan' to view what will be created and the output will be stored in solution.plan
c) Run 'terraform apply solution.plan' to build the infrastructure components such as VM, vnet , load balancer, Public IP, NSG, NIC as per the plan

![Terraform_Infrastructure_Creation](https://user-images.githubusercontent.com/18601050/182712273-b4b2c1fa-0365-4020-a380-407e6013849f.PNG)

Once the infrastructure has successfully been deployed, we want to then destroy the infrastructure. In the Azure CLI run the command terraform destroy.
Run terraform show again to confirm all resources have been destroyed, as mentioned below -

![Terraform_destroy](https://user-images.githubusercontent.com/18601050/182712431-b81e25af-fc13-4d0e-a994-5f9f4cf7667d.PNG)




