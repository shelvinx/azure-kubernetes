# AKS Terraform Deployment [WIP]

This project provisions an Azure Kubernetes Service (AKS) cluster using Terraform and deploys an NGINX workload to the cluster using Kubernetes manifests. The setup includes Azure AD integration, managed identities, a system and spot node pool, and a sample deployment with autoscaling.

## Project Structure

- `avm.aks.tf`: Terraform configuration for deploying the AKS cluster using the Azure Verified Module (AVM).
- `variables.tf`: Terraform variable definitions for sensitive and required inputs.
- `nginx-deployment.yaml`: Kubernetes manifest for deploying an NGINX deployment with three replicas.
- `nginx-service.yaml`: Kubernetes manifest for exposing NGINX via a LoadBalancer service.
- `nginx-hpa.yaml`: Kubernetes manifest for a Horizontal Pod Autoscaler (HPA) for the NGINX deployment.

## Prerequisites

- [Terraform](https://www.terraform.io/) v1.11.4
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)
- [kubectl](https://kubernetes.io/docs/tasks/tools/)

## Setup Instructions

**Configure Terraform Variables**
   - Update the `variables.tf` file or provide a `terraform.tfvars` file with required values:
     - `location`: Azure region for resource deployment.
     - `suffix_workload`: Suffix for workload naming (string).
     - `cluster_admin_user_object_id`: Azure AD Object ID for cluster admin RBAC.

**Configure kubectl**
   After deployment, configure your local kubeconfig:
   ```sh
   az aks get-credentials --resource-group <RESOURCE_GROUP> --name <AKS_CLUSTER_NAME>
   ```

**Deploy Workloads**
   Apply the Kubernetes manifests to deploy NGINX and configure autoscaling:
   ```sh
   kubectl apply -f nginx-deployment.yaml
   kubectl apply -f nginx-service.yaml
   kubectl apply -f nginx-hpa.yaml
   ```

## Features

- **AKS Cluster**: Provisioned with Azure AD integration, managed identities, and RBAC.
- **Node Pools**: Includes a system node pool and a spot node pool for cost optimization.
- **NGINX Deployment**: Deploys a sample NGINX workload with resource requests and limits.
- **LoadBalancer Service**: Exposes NGINX externally via Azure Load Balancer.
- **Horizontal Pod Autoscaler**: Scales NGINX pods based on CPU utilization.

## Notes
- The AKS module uses the Azure Verified Module from the Terraform Registry.
- Ensure you have the necessary Azure AD permissions for RBAC and managed identities.
- Update the `admin_group_object_ids` in `avm.aks.tf` if you need to specify Azure AD groups for admin access.

## License
This project is provided as-is, without warranty. Licensing terms may apply based on your usage of Azure and Terraform modules.
