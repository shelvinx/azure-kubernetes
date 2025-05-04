# Create AKS with Azure Verified Module
# A Terraform module to create an AKS cluster with a single node pool and Azure AD integration.
module "aks" {
  source  = "Azure/avm-res-containerservice-managedcluster/azurerm"
  version = "0.1.8"

  name                     = module.naming.kubernetes_cluster.name
  resource_group_name      = module.rg.name
  node_resource_group_name = "MC_${module.rg.name}"
  location                 = var.location
  sku_tier                 = "Free" # Test env does not require uptime sla

  # Required system node pool
  default_node_pool = {
    name                         = "system"
    vm_size                      = "Standard_B2s"
    os_disk_type                 = "Managed"
    os_disk_size_gb              = 32
    node_count                   = 1
    only_critical_addons_enabled = true
  }

  # User defined node pool
  node_pools = {
    spot = {
      name            = "spot"
      vm_size         = "Standard_D2as_v6"
      priority        = "Spot"
      eviction_policy = "Delete"
      spot_max_price  = -1
      node_count      = 1
      mode            = "User"
      os_disk_type    = "Managed"
      os_disk_size_gb = 64
    }
  }

  # Managed identities
  managed_identities = {
    system_assigned = true
  }

  # Azure AD integration
  azure_active_directory_role_based_access_control = {
    managed                = true
    admin_group_object_ids = []   # Needs at least an empty list, add your AAD Group Object ID here if needed
    azure_rbac_enabled     = true # Often desired with managed AAD
  }

  # Corrected role_assignments structure
  role_assignments = {
    # Key: A unique name for this specific assignment
    cluster_admin_rbac_user = {
      # Using the role definition ID is generally more reliable
      role_definition_id_or_name = "Azure Kubernetes Service RBAC Cluster Admin"
      principal_id               = var.cluster_admin_user_object_id
    }
  }
}