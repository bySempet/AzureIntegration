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