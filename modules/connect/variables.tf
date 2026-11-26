
variable "instance_id" {
  type = string
}

variable "user_name" {
  type = string
}

variable "user_password" {
  type      = string
  sensitive = true
}

variable "first_name" {
  type = string
}

variable "last_name" {
  type = string
}

variable "routing_profile_name" {
  type = string
}

variable "security_profile_name" {
  type = string
}

variable "default_outbound_queue_id" {
  type = string
}

variable "fraud_queue_id" {
  type = string
}

variable "cards_queue_id" {
  type = string
}

variable "contact_flow_id" {
  type = string
}

variable "quick_connect_name" {
  type = string
}
