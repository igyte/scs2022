variable "enable_ddos_protection_plan" {
  type        = bool
  description = "If set to true, will deploy DDoS Protection Standard plan and link to hub networks."
  default     = false
}

variable "primary_location" {
  type        = string
  description = "Sets the location for \"primary\" resources to be created in."
  default     = "northeurope"
}

variable "root_id" {
  type        = string
  description = "Sets the value used for generating unique resource naming within the module."
  default     = "alz-demo"
}

variable "root_name" {
  type        = string
  description = "Sets the display name of the \"root\" Management Group."
  default     = "Azure landing zone demo"
}

variable "secondary_location" {
  type        = string
  description = "If specified, sets the location for \"secondary\" connectivity resources to be created in."
  default     = ""
}

variable "security_contact_email_address" {
  type        = string
  description = "Sets a custom value for the security contact email address."
  default     = "test.user@replace_me"
}

variable "subscription_id_connectivity" {
  type        = string
  description = "Sets the subscription ID to use for \"connectivity\" resources."
  default     = ""
}

variable "subscription_id_identity" {
  type        = string
  description = "Sets the subscription ID to use for \"identity\" resources."
  default     = ""
}

variable "subscription_id_management" {
  type        = string
  description = "Sets the subscription ID to use for \"management\" resources."
  default     = ""
}

variable "subscription_ids_corp" {
  type        = list(string)
  description = "Sets the subscription IDs to assign to the \"corp\" management group."
  default     = []
}

variable "subscription_ids_online" {
  type        = list(string)
  description = "Sets the subscription IDs to assign to the \"online\" management group."
  default     = []
}
