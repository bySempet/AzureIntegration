
This documentation is personal and is my way of understanding the Azure Official Documentation for the AZ-900, AZ-194 and AZ-400.

As AWS Microsoft Azure is a cloud computing platfrom with houndreds of services, that can help you host internet facing apps, virtual machines, remote storage, databases and account management. It also provides IA solutions.

This is how the AZ-900 Certification Exam is divided:
![](images/Pasted%20image%2020260928173837.png)

As always, what is cloud computing?
Is the delivery of computing service over the internet, in the case of Azure/AWS this platform give you the oportunnity to build your infraestructure over the internet and scale it in a mather of seconds, instead of having to build it on-premise

Azure also has the shared responsibility model, between the cloud-provider and the customer. As always they are  responsible for the hardware side of all of it and you are responsible for the software side of what you build, data and info.

![](images/Pasted%20image%2020260928174441.png)

The cloud type:
- Private Cloud: On-premise
- Public Cloud: AWS or Azure
- Hybrid Cloud: Combination of the last two
- Multicloud: AWS and Azure together

CapEx and OpEx, the first one means spending money on physical infraestructure while the second one means spending on services over time. Pay-as-you-go model, only pay for what you use.

This is the catalog of services that you can use:
![](images/Pasted%20image%2020260928175651.png)

Needed Azure Subscription, for my case is the free tier. 200$ free for trial
Okay so, as in AWS you have your root account that you shouldnt use in any case. In Azure you have mostly the same, you have your created account and subscriptions. An account can have multiple subscriptions for different enviroments or teams. 


The way they explain the infraestructure of Azure is the same as in AWS, Regions and AZ:
![](images/Pasted%20image%2020260928180352.png)

Most regions and geo-connected in 300 miles. This helps not interrumpting the service of the customers
There are a few regions that are isolated from the other ones:
![](images/Pasted%20image%2020260928180921.png)

Anything that is created is called a resource, VMs, VNetworks, databases...
Each resource belongs exactly to one resource group. JUST ONE, ALWAYS.
From now on, resource group is RG(Resource Group).
You can move resources between RG.
You cannot have a RG inside another RG. If you delete a RG you delete all the resources inside of it. Granting acces to a RG grants access to all his content.

Subscriptions are the way of management , billing and scale. One account multiple subscriptions, multiples bills. One subscription can have access to multiple RG and resources while a PROD subcription doesnt.

The way all the hierarqhy is build:
- When you create an account the first time, it creates a Tenant.
- This tenant is where all the users and groups are defined. 
- In the tenant you can give access to groups and users to different subscriptions
- The rol that you give to a user/group in a subscriptions is for all the RG and resources in the subcription
- So better to give permission to the RG or resource if needed instead of all the subscription
Azure management groups sit above subscriptions. You organize subscriptions into management groups and apply governance conditions.

![](images/Pasted%20image%2020260928183326.png)

Virtual Machines work as the EC2. Creating a VM you need to choose:
- Size (purpose, number of processor cores, and amount of RAM)
- Storage disks (hard disk drives, solid state drives, etc.)
- Networking (virtual network, public IP address, and port configuration)

Types of azure size

![](images/Pasted%20image%2020260928190957.png)
![](images/Pasted%20image%2020260928191031.png)

They use the name of the VM to explain how it is configured:
![](images/Pasted%20image%2020260928191233.png)

Dont think this is actually used by organizations to name their machines 

Azure virtual Desktop is an application virtualization service in Azure. Is better to set up a Virtual Desktop than define multiple VM for different groups.
They are explaining what are containers and how they work at first, the difference between a VM and a container. They talk abour Azure Container Instances, which is the fastest way to run a container in Azure, no VM, just upload the container and it runs it for you.

Azure Container Apps give you the opportunity to balance and scale your containers as needed
Finally the big one, AKS, the same as EKS( Kubernetes)
We reach to Azure functions, which is the same as Lambda. Run light code without a VM or Container. It can be activated after and event which triggers the function and then gives a respond to another part of the Infraestructure, fexample, an API.
You pay for the compute time, which means for the CPU used while Azure Functions is working.
They can be stateless or statefull, stateless functions behave the same way every time while statefull functions can act in different ways according to the imputs they recieve

Azure AI services, some usefull AI scenarios you can use for documentation and language.
Azure OpenAI, for chatbots seems very usefull.
Azure Machine Learning model, look cool for exploiding data

Application Hosting described

![](images/Pasted%20image%2020261001183844.png)

App Service, is their way of giving you the oportunitty of building all the code but not having to manage the infra.

Azure VirtualNetworking
Azure networks and subnets enable different resources to communicate with each other
They give the following capabilities:
- Isolation and segmentation
- Internet communications
- Communicate between Azure resources
- Communicate with on-premises resources
- Route network traffic
- Filter network traffic
- Connect virtual networks
There is a DNS service in Azure.
The best way is to define a load balancer/proxy to receive the incomming traffic and then send it to the inside network resources/services

Communicate with on-premise resources
Three ways of doing it:
- Point-to-site, virtual private network connections are from a computer outside your environment back into your private network. In this case, the client computer initiates an encrypted VPN connection to connect to the Azure virtual network. This means you have an on-premise server who can stablish a connection to you Azure environment
- Site-to-site, virtual private networks link your on-premises VPN device or gateway to the Azure VPN gateway in a virtual network. In effect, the devices in Azure can appear as being on the local network. The connection is encrypted and works over the internet.
- Azure ExpressRoute provides a dedicated private connectivity to Azure that doesn't travel over the internet. ExpressRoute is useful for environments where you need greater bandwidth and even higher levels of security. 

Routing traffic inside networks:
- Route tables let you define rules about how traffic should be directed. You can create custom route tables that control how packets are routed between subnets.
- Border Gateway Protocol (BGP) works with Azure VPN gateways, Azure Route Server, or Azure ExpressRoute to propagate on-premises BGP routes to Azure virtual networks.
- User-defined routes (UDR) let you control the routing tables between subnets within a virtual network or between virtual networks, giving you greater control over network traffic flow.

Network security groups, they are the resource where you can define inbound and outbound rules.
Network virtual appliances, its like a firewall. They are specialized VM that you can put between you load balancer and you network to filter traffic.

![](images/Pasted%20image%2020261002182247.png)

You can connect different Vnetworks by using the network peering. It lets you connect to virtual networks, the connections flows inside Microsofts internal network, so no communication goes by the public internet. You can connect virtual networks from different regions

![](images/Pasted%20image%2020261002182721.png)

VPN(Virtual Private Network)
We all know what VPNs do, connect two or more network that are connected between an untrusted network, generally the public network.
There are 3 models of VPN gateways:

![](images/Pasted%20image%2020261002183318.png)

Very important fact, only one VPN gateway can be deployed in a VNet.
There are 2 types of VPNs, policy-based of route-based. Their difference is how they determine when to encrypt traffic-
Policy-based ones, have a list of IP adress that have to be encrypted, if the package is in the list is encrypted. In route-based gateways, IPSec tunnels are modeled as a network interface or virtual tunnel interface.

Azure ExpressRoute
Lets you extend your on-premise network into the Microsoft cloud using a private network with the help of a connectivity provider. The expressRoute connections dont go voer the public internet, thats why they offer better speed, latencies and security.

Several benefits from using ExpressRoute:
- Connectivity to Microsoft cloud services across all regions in the geopolitical region.
- Global connectivity to Microsoft services across all regions with the ExpressRoute Global Reach.
- Dynamic routing between your network and Microsoft via Border Gateway Protocol (BGP).
- Built-in redundancy in every peering location for higher reliability.

From my point of view, lots of start ups are not gonna use this because they dont have any on-premise infra. So this is focuse for mid and high tech companies.

Azure DNS is a hosting service for DNS domains:
Some benefits:
- Reliability and performance: The resolution goes to the nearest Azure DNS server
- Security: Azure resource manager, provides Azyre role-based access control
- Ease of use: You can use from inside and outside
- Customizable virtual networks: Also provides private domains
- Alias records: You can set an alias to a resource, if that resource changes IP the DNS resolution will update the IP to the alias


Azure Storage Services

Blob Storage is the way of storing unstructured data, like S3
Azure Fileshare, basically NFS
Disc storage, provide storage for VMs and BDs
Table Storage, non-sql to store non unstructured data
Azure Queue storage, comunnicating between aplications.
Hard,cool and archieve. Hard is for common acces, cole for not common acces and finally archieve for backups.
Redundancy options for the storage account: 
- Locally redundant storage (LRS):replicates your data three times within a single data center in the primary region
- Geo-redundant storage (GRS): Applies a LRS in both first and second region
- Read-access geo-redundant storage (RA-GRS)
- Zone-redundant storage (ZRS): replicates your Azure Storage data synchronously across three Azure availability zones in the primary region
- Geo-zone-redundant storage (GZRS): Applies ZRS in the first one and LRS in the second one
- Read-access geo-zone-redundant storage (RA-GZRS): Enable so you can read data from the second region before failing

One of the benefits of using an Azure storage account is having a unique namespace in Azure for your data. Every storage account must have a unique account name within Azure. Storage account names must be between 3 and 24 characters in length and may contain numbers and lowercase letters only. Your storage account name must be unique within all Azure, so probably better to give a name and then a number bases sufix.

Azure Blob storage is an unstructured object storage service for large volumes of text or binary data. It's designed for scenarios such as large uploads, media content, log files, and analytics datasets. Developers store objects as blobs while Azure handles the underlying storage infrastructure.

Blob storage is ideal for:

- Serving images or documents directly to a browser.
- Storing files for distributed access.
- Streaming video and audio.
- Storing data for backup and restore, disaster recovery, and archiving.
- Storing data for analysis by an on-premises or Azure-hosted service

![](images/Pasted%20image%2020261003114402.png)

Azure Files, it can use NFS or SMB. NFS linux and macos and SMB for Windows

Azure Queue storage stores large numbers of messages for asynchronous processing. Queues are accessed by authenticated HTTP/HTTPS calls, can hold millions of messages, and support messages up to 64 KB.
Queue storage is commonly paired with Azure Functions so messages trigger background actions.

Azure Disk storage (managed disks) provides block-level volumes for Azure VMs. They are virtualized and managed by Azure for improved resiliency and simpler operations.

Azure Table storage is a NoSQL store for large amounts of structured, non-relational data, accessible through authenticated calls from cloud and hybrid environments.

There are 2 options to migrate the data from the on-premise servers to the Azure Cloud

![](images/Pasted%20image%2020261003115333.png)

The Azure Migrate are a group of tools that help you migrate the data. 
The Azure Data Box is a physical migration where they give you a Data Box device that has 80 terabytes and it is delivered via a regional carrier.
They are focused on big large of data, for smaller data packages we can use the next 3:

![](images/Pasted%20image%2020261003115708.png)

When you want to copy files you use the first two. When you want to have a FS syncroniched in you computer you use Azure File Sync

Azure directory services
Microsoft Entra ID is the service for identity and acess management. Similar to AD.
It is used by IT admins, App devs, usersm and online services
- **Authentication** — Verifies identity before granting access. Includes self-service password reset, multifactor authentication, banned password lists, and smart lockout.
- **Single sign-on (SSO)** — Lets one identity access multiple applications. SSO benefits and behavior are covered in the authentication methods unit.
- **Application management** — Manages cloud and on-premises apps through features like Application Proxy, SaaS app integration, and the My Apps portal.
- **Device management** — Supports device registration and management through tools like Microsoft Intune. Enables device-based Conditional Access policies that restrict access to known devices.
Microsoft Entra Connec is the service to connect your on premise AD with the Microsoft Entra

![](images/Pasted%20image%2020261004183158.png)
 
 Passwordless methods eliminate the password entirely, replacing it with a trusted device plus a biometric signal or PIN.
 Microsoft Entra ID supports three passwordless options:
- Windows Hello for Business: The biometric and PIN credentials are directly tied to the user's PC, which prevents access from anyone other than the owner
- Microsoft Authenticator app: To sign in, the user receives a notification on their phone, matches a number displayed on screen, and confirms with a biometric signal (touch or face) or PIN.
- FIDO2 security keys: A hardware device that handles all the work

Microsoft Entra External ID includes the capabilities used to securely interact with users beyond your tenant boundary. You may need to work with partners, so you can let those users access your resources with their credentials.
The external identity provider manages authentication, and you manage authorization to your applications with Microsoft Entra ID or Azure AD B2C.

B2B collaboration: You let the usese choose their preferred identity to sing in to your applications
**B2B direct connect** - Establish a mutual, two-way trust with another Microsoft Entra tenant for seamless collaboration

Conditional Access is a tool that Microsoft Entra ID uses to allow (or deny) access to resources based on identity signals. It is used when:
- Require multifactor authentication (MFA) to access an application depending on the requester’s role, location, or network. For example, you could require MFA for administrators, or for people connecting from outside trusted network locations.
- Require access to services only through approved client applications. For example, you could limit which email applications are able to connect to your email service.
- Require users to access your application only from managed devices.
- Block access from untrusted sources, such as access from unknown or unexpected locations.

RBAC- role based access. You can create different roles and grant them when a user is created.
Role-based access control is applied to a scope, which is a resource or set of resources that this access applies to.

Defense in-depth
The objective of defense-in-depth is to protect information and prevent it from being stolen by those who aren't authorized to access it.
A defense-in-depth strategy uses a series of mechanisms to slow the advance of an attack that aims at acquiring unauthorized access to data.

![](images/Pasted%20image%2020261004185046.png)

Azure Key Vault

Azure Key Vault is a service for securely storing and controlling access to:
- Secrets
- Encryption keys
- Certificates

Using Key Vault helps centralize secret and key management instead of storing sensitive values directly in application code or configuration files.

Factors that can affect costs
There are a few key factors:
- Resource type: You have to be aware of the usage you make of the resources, is better to have a smaller VM at 70-80% that a better machine that costs more at 30-40%
- Consumption: You can have discount options if you reserve a specific resource for one-to-three years.
- Maintenance: You have to be aware of the services you have, you may eliminate a machine but not all the dependencies that are created when you deploy it
- Geography: Depends on what region you are, the cost can differ
- Subscription type: Depending of the subscription you have, you cost can change
- Azure Marketplace: lets you purchase Azure-based solutions and services from third-party vendor

![](images/Pasted%20image%2020261005173453.png)

Pricing calculator, it also exists in AWS. Very similar 
Cost Management provides the ability to quickly check Azure resource costs, create alerts based on resource spend, and create budgets that can be used to automate management of resources.
Budget alerts notify you when spending reaches or exceeds a threshold you define. You can create budgets in the Azure portal or through the Azure Consumption API.
Credit alerts are generated automatically at 90% and at 100% of your Azure credit balance
Tagging the resources is important to keep everything well defined

Azure Cloud Shell

Is a browser-accesible command-line experience for managing Azure. Its used when you are wirh your work PC and you have to access you resources.

![](images/Pasted%20image%2020261005181829.png)

You can ran Bash or Powershell, you can ran code and it will give you code editor like VS.
You can download or upload any files, commonly use CloudDrive to use scripts in the CloudShell
You can use Azure Cloud Shell to:
- Open a secure command-line session from any browser-based device.
- Interact with Azure resources without the need to install plug-ins or add-ons to your device.
- Persist files between sessions for later use.
- Use either Bash or PowerShell, whichever you prefer, to manage Azure resources.
- Edit files (such as scripts) via the Cloud Shell editor


Azure Resource manager Template (ARM Templates) AWS CloudFormation
A way od describing your infraestructure in code, like Terraform.
In this case they are described in JSON files in and declarative way.
ARM templates allows you to automate de deployment of the infraestructure.
They are idempotent, which means you can deploy the same template as many times as you want in the same state. It also has a built-in validation before the stage of deployment.
You can build smaller components to reuse them in the future  -> You can integrait it with Azure pipelines (CI/CD)
As always you need to create a RG or use one that was created before

az group create --name {name of your resource group} --location "{location}"
templateFile="{provide-the-path-to-the-template-file}"
az deployment group create --name blanktemplate --resource-group myResourceGroup --template-file $templateFile

For a storage Account you need the  `Microsoft.Storage` provider, i saw it when i started creating the Terraform project.

![](images/Pasted%20image%20261009175330.png)

The way od defininf the default RG:

Set-AzDefault -ResourceGroupName <ResourceGroupName>
$templateFile="azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addstorage-"+"$today"
New-AzResourceGroupDeployment -Name $deploymentName -TemplateFile $templateFile

ARM-template parameters let you customize the deployment by providing values that are tailored for a particular environment, you pass in different values based on whether you're deploying to an environment for development, test, production, or others.
In your ARM template's outputs section, you can specify the values that are returned after a successful deployment
This is pretty much the same as Terraform and CloduFormation.
You can have variables, modules, local variables, outputs...

Understanding in depth the Microsoft Entra ID
We can tell that Entra ID is a not self-hosted service that let you have access to more features that a common AD has, multi-factor auth, identity provider and self-service pwd.
Any subscription beside the free one gives you full access to the fre features.
Different version of Entra ID are offered in the basic or premium tiers as part of Microsoft 365 subscription