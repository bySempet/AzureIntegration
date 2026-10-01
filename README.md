# AzureIntegration
Anotaciones Importantes durante el proceso de generación del state local, es decir, la generacion de la infraestructura que almacenara el state del resto del proyecto. State local de infra que almacena el state cloud.

Elementos necesarios, resource_group, storage_account y storage_container. Las storage_accounts dependen del resource_grup y el container del storage_account. Para que se generen siempre en el orden necesario,
se debe de definir con la siguiente nomenclatura "type.definedResourceName.variable", en la variable que necesita de dependencia.

Always "terraform init" -> "terraform validate" -> "terraform plan" -> check what is going to be created and lastly -> "terraform apply".

If any resource has been correctly created during the apply but the creation of the config hasnt been complete, you can check with "terraform state list" what has been created and what not. Then "terraform destroy" to eliminate those resources

In new accounts for Azure, sometimes theres a problem with the Regions you can acces to. For example i used West Europe and didnt let me create some resources there. That is why i changed it to Spain Central. The current configuration uses North Europe.

After `terraform apply`, run `terraform output backend_config` to get the `backend "azurerm"` block for the main project.

Im encounting this problem where the Storage Account is trying to be created but the resource_group cant me access for some reason. Then this resource is being taged as *tainted*, whis means is corrupted for terraform, so the next time you want to apply it is going to be recreated -> destroyed and created.

To make this work, i added a fixed waiting time so all the resources are created correctly before any other one that depends on them are created.
To define a *backend* for azure there are 4 ways of doing it(as it states in the official documentation):
- Microsoft Entra ID (Recommended)
- SAS Token (Not recommended for new workloads)
- Access Key (Not recommended for new workloads)
- Access Key Lookup (Not recommended for new workloads)

As recommended we are going to use the first one. To make it work we have to grant the user that we are using the role of "Storage Blob Data Contributor", besides being the owner we need the rol to access the Blob Storage inside the Storage Account. For that we define a role assingment in the definition of the *azure_backend*, we take the id of the account being used to assing the role.

The next step is to build the code to deploy a VM in azure. After creating the enviroment to contain everything.
To build a VM we need to generate a network and then define all the properties needed for creating a VM. Because is something I may use in other projects and is a standar in Terraform, im going to build two *Modules* for this two steps. For any new terraform user, modules are the way of building and abstract declaration of an element.
In this case we can define a module of a VM, that we may use in different projects, then create another one for the network.

A module works like a function. The variables are the parameters, the resources are the body and the outputs are what it returns. The *main_backend* is the one that calls the modules, which are in the *modules* folder (network and vm). The order of the .tf files doesnt matter, terraform reads all of them at the same time and decides the order with the dependencies.

The network module has the VNet, the subnet, the NSG(which is the firewall) and the association of the NSG to the subnet. The NSG only lets in SSH from my IP, everything else is blocked by default by Azure. To avoid opening SSH to everyone, the variable of the IP has a validation that doesnt let you use 0.0.0.0/0. This was a recommendation from the official documentation.

The vm module has the public IP, the NIC and the Ubuntu VM, that you can only access with the SSH key, not with password. It also has an automatic shutdown every day at 23:00 so it doesnt keep spending money if i forget to turn it off. For this one we need to register "Microsoft.DevTestLab" in the provider.

When i tried to check the VM sizes with "az vm list-skus" i got an SSL certificate error. The problem is the AVG antivirus, that intercepts the HTTPS traffic.

To see what VMs are available in this region, with the command *az vm list-skus --location northeurope --resource-type virtualMachines* you get all the available machines in the northeourope region, then i have to filter all the content to select which can i use. My subscription doesnt allow to use all the sizes for the VM that exists

The VM size i wanted to use (Standard_B2ats_v2) appeared as "NotAvailableForSubscription" in northeurope, 
the same kind of problem as with the regions. Listing the sizes with 2 vCPUs or less that are not restricted,
only the F, DC and EC families were available. So after consulting the IA it taught me that the DC and EC are confidential VMs, that need special images and configuration, so i chose Standard_F1s

I had destroyed the azure_backend, so i had to apply it again. The Storage Account has a random name, so the new one was different and i had to change it in *backend.hcl*. Then "terraform init -reconfigure -backend-config=backend.hcl", the -reconfigure is needed because the backend changed.

To deploy it: put your IP with /32 in terraform.tfvars -> check the VM size is available with "az vm list-skus" -> "terraform init" -> "terraform validate" -> "terraform plan" -> "terraform apply" -> "terraform output ssh_command" to connect.

After doing the *terraform apply* it creates 7 resources and then shows the next *Error* 'SkuNotAvailable: The requested VM size for resource 'Following SKUs have failed for Capacity Restrictions: Standard_F1s' is currently not available in location 'northeurope'.
After checking, it means that this type of machine with this resources it is not available to create a new one on this region. 