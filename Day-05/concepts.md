# Azure Networking

## Virtual Network

A Virtual Network (VNet) in Azure is a logically isolated network dedicated to your subscription that securely connects Azure resources and extends on-premises networks. Think of it as creating your own isolated network segment inside a Azure's massive Data center. Key features include:

- **Isolation**: VNets provide isolation at the network level for segmenting resources and controlling traffic.

- **Subnetting**: Divide a VNet into subnets for resource organization and traffic control.

- **Address Space**: VNets have an address space defined using CIDR notation, determining the IP address range.

## Subnets, CIDR

### Subnets

Subnets are subdivisions of a Virtual Network, allowing for better organization and traffic management.

### CIDR (Classless Inter-Domain Routing)

CIDR notation represents IP addresses and their routing prefix, specifying the range of IP addresses for a network.
In other words, CIDR is a method of allocating IP addresses and route internet traffic efficiently. It allows network administrators to create
custom sized networks by specifying exactly how many bits are used for network portion of an IP address

<img width="410" height="130" alt="image" src="https://github.com/user-attachments/assets/8d5b204a-0ab3-4e24-9a4c-9cf4f7dca83e" />


## Routes and Route Tables

### Routes

Routes dictate how network traffic is directed, specifying the destination and next hop.

### Route Tables

Route Tables are collections of routes associated with subnets, enabling custom routing rules. Each route within a table specifies a destination IP address range and the next hop type. A hop type can be anything.

Also, custom route tables let you control within your VNet and between your VNet and other networks.

Common hop types includes:

    - Virtual Appliances like Azure Firewall
    - Internet
    - None (Drop Route)

<img width="920" height="165" alt="image" src="https://github.com/user-attachments/assets/72759e98-71d3-493e-9226-1f107a727f50" />      


## Network Security Groups (NSGs)

NSGs are fundamental for Azure's network security, allowing filtering of inbound and outbound traffic. Key aspects include:

- **Rules**: NSGs define allowed or denied traffic based on source, destination, port, and protocol.

- **Default Rules**: NSGs have default rules for controlling traffic within the Virtual Network and between subnets.

- **Association**: NSGs can be associated with subnets or individual network interfaces.

 <img width="456" height="579" alt="image" src="https://github.com/user-attachments/assets/01c9ffca-521d-495c-be10-219e767e5204" />


  <img width="454" height="573" alt="image" src="https://github.com/user-attachments/assets/f95f8668-3efa-4342-af20-301b25717c10" />






## Application Security Groups (ASGs)

ASGs group Azure virtual machines based on application requirements. ASGs enable network security group policies to be defined using logical application groupings rather than individual VMs IP addresses. Hence, simplifying network security:

- **Simplification**: ASGs allow defining rules based on application roles instead of individual IP addresses.

- **Dynamic Membership**: ASGs support dynamic membership based on tags or other attributes.

- **Rule Association**: Security rules can be associated with ASGs for intuitive and scalable network security management.

## ASG Benefits

- **Consistent Security Policies** across a group of VMs

- **Scalability**, ASGs automatically adjust to accomodate changes in VM.
