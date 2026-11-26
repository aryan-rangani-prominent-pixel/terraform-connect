# # variable "ialias" {
# #   default = data.aws_connect_instance.instance_alias
# # }
# # variable "iid" {
# #   default = data.aws_connect_instance.id
# # }
# # variable "identity_type" {
# #   default = data.aws_connect_instance.identity_management_type
# # }
# # variable "inbound" {
# #   default = data.aws_connect_instance.inbound_calls_enabled
# # }
# # variable "outbound" {
# #   default = data.aws_connect_instance.outbound_calls_enabled
# # }
# # variable "configure_storage" {
# #   default = aws_connect_instance_storage_config.storageandkms
# # }
# # variable "hoo" {
# #   default = aws_connect_hours_of_operation.office_hours
# # }
# # variable "existing_user" {
# #   default = data.aws_connect_user.existing_user
# # }

# # # variable "users" {
# # #   type = map(object({
# # #     first_name=string
# # #     last_name=string
# # #     routing_profile_id=string
# # #   }))

# # #   default = {
# # #     "demo" = {
# # #       first_name = "bank"
# # #     last_name = "agent123"
# # #       routing_profile_id = aws_connect_routing_profile.new_routing.id
# # #     }
# # #   }
# # # }

# # variable "routing_profile" {
# #   default = aws_connect_routing_profile.new_routing.id
# # }

# # variable "security_profiles" {
# #   default = aws_connect_security_profile.new_sp_demo.id
# # }
# # variable "card_q" {
# #   default = data.aws_connect_queue.id
# # }

# # # variable "second_q" {
# # #   type = map(object({
# # #     hours_of_operations_id=string
# # #   }))
# # #   default = {
# # #     "fraud" = {
# # #       hours_of_operations_id = aws_connect_hours_of_operation.office_hours.id
# # #     }
# # #   }
# # # }

# # variable "quick" {
# #   default = data.aws_connect_quick_connect.existing_connect.id
# # }

# # variable "lambda" {
# #   default = data.aws_connect_lambda_function_association.demo_lambda.id
# # }

# # variable "main_flow" {
# #   default = aws_connect_contact_flow.demo_with_tf.id
# # }




# # variable "sensitive" {
# #    default = "password123"
# #    sensitive = true
# # }





variable "user_name" {
  type    = string
  default = "ar_demo"
}

variable "user_password" {
  type      = string
  sensitive = true
}

variable "first_name" {
  type    = string
  default = "bank"
}

variable "last_name" {
  type    = string
  default = "agent123"
}

variable "routing_profile_name" {
  type    = string
  default = "ar_bank_routing_demo_profile"
}

variable "security_profile_name" {
  type    = string
  default = "ar_demo_sec"
}



variable "contact_flow_id" {
  type    = string
  default = "416ae9d3-f6dd-4e00-bd62-8c4c3a49e79c"
}

variable "quick_connect_name" {
  type    = string
  default = "ar_demo_connect_bank"
}
