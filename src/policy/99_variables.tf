variable "location" {
  type        = string
  description = "Location/Region name"
}

variable "metadata_category_name" {
  type        = string
  description = "metadata category name"
}

#
# Parameters values
#
variable "tags_subscription_to_inherith" {
  type        = list(string)
  description = "Tag that must be inherith by the subscription"
}

#
# Allowed Skus
#
variable "devops_vm_skus_allowed" {
  type        = list(string)
  description = "list of skus allowed into management group devops"
}

variable "dev_vm_skus_allowed" {
  type        = list(string)
  description = "list of skus allowed into management group dev"
}

variable "uat_vm_skus_allowed" {
  type        = list(string)
  description = "list of skus allowed into management group uat"
}

variable "prod_vm_skus_allowed" {
  type        = list(string)
  description = "list of skus allowed into management group prod"
}

#
# Allowed Locations
#
variable "devops_allowed_locations" {
  type        = list(string)
  description = "List of allowed locations for devops"
}

variable "dev_allowed_locations" {
  type        = list(string)
  description = "List of allowed locations for dev"
}

variable "uat_allowed_locations" {
  type        = list(string)
  description = "List of allowed locations for uat"
}

variable "prod_allowed_locations" {
  type        = list(string)
  description = "List of allowed locations for prod"
}

variable "certificate_authority_cn" {
  type        = string
  description = "The common name that the certificates must use"
}

locals {
  cstar_prod_subscription_id = "88c709b0-11cf-4450-856e-f9bf54051c1d"
  io_prod_subscription_id    = "ec285037-c673-4f58-b594-d7c480da4e8b"
}
