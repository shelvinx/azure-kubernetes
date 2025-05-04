variable "HCP_CLIENT_ID" {
  type      = string
  sensitive = true
}

variable "HCP_CLIENT_SECRET" {
  type      = string
  sensitive = true
}

variable "suffix_workload" {
  type = string
}

variable "location" {
  type = string
}

variable "cluster_admin_user_object_id" {
  description = "The Azure AD Object ID of the user to grant AKS Cluster Admin RBAC role."
  type        = string
  sensitive   = true
}