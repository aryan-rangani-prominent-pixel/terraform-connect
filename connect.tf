# data "aws_connect_instance" "existing" {
#   //instance_alias = "digiclarity-training-v1"
#   instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
#   //identity_management_type = "CONNECTED_MANAGED"
#   //inbound_calls_enabled = true
#   //outbound_calls_enabled = true
# }

data "aws_connect_instance" "existing" {
  instance_alias = "digiclarity-training-v1"
}

# /*resource "aws_connect_instance_storage_config" "storageandkms" {
#     instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
#     resource_type = "CALL_RECORDINGS"
#     storage_config {
#       storage_type = "s3"
#       s3_config {
#         bucket_name = "amazon-connect-ca163e6f14bc"
#         bucket_prefix = "transcript"
#         encryption_config {
#           encryption_type = "KMS"
#           key_id = "arn of key"
#         }
#       }
#     }
# }*/

# data "aws_connect_user" "existing_user" {
#   instance_id = data.aws_connect_instance.existing.id
#   user_id     = "d9d26db8-1167-419a-8e09-65aed2e8da2e"
# }

# resource "aws_connect_user" "demo_user" {
#   instance_id = data.aws_connect_instance.existing.id
#   name = "demo"
#   password = var.password
#   routing_profile_id = aws_connect_routing_profile.new_routing.id
#   security_profile_ids = [
#     aws_connect_security_profile.new_sp_demo.id
#   ] 
#   identity_info {
#     first_name = "bank"
#     last_name = "agent123"
#   }
#   phone_config {
#     after_contact_work_time_limit = 0
#     phone_type = "SOFT_PHONE"
#   }
# }

# /*data "aws_connect_routing_profile" "existing_profile" {
#   instance_id = data.aws_connect_instance.existing.id
#   name        = "ar_Card_Routing"
# }*/

# resource "aws_connect_routing_profile" "new_routing" {
#   instance_id = data.aws_connect_instance.existing.id
#   name = "ar_bank_routing_demo_profile"
#   default_outbound_queue_id = data.aws_connect_queue.fraud_queues.queue_id //bank fruad
#   description = "for demo only"
#   media_concurrencies {
#     channel = "VOICE"
#     concurrency = 1
#     cross_channel_behavior {
#       behavior_type = "ROUTE_ANY_CHANNEL"
#     }
#   }

#   queue_configs {
#     channel = "VOICE"
#     delay = 0
#     priority = 1
#     queue_id = data.aws_connect_queue.fraud_queues.queue_id //bank fruad
#   }
# }

# /*data "aws_connect_security_profile" "existing_security" {
#   instance_id = data.aws_connect_instance.existing.id
#   name        = "ar_Bank_Agent_Security"
# }*/

# resource "aws_connect_security_profile" "new_sp_demo" {
#   instance_id = data.aws_connect_instance.existing.id
#   name = "ar_demo_sec"
#   description = "for the demo"
#   permissions = [
#     "BasicAgentAccess",
#     "OutboundCallAccess",
#     "CallRecordings"
#   ]
# }

# /*resource "aws_connect_hours_of_operation" "office_hours" {
#   instance_id = data.aws_connect_instance.existing.id
#   name        = "Business Bank Hours"
#   description = "Standard office hours"
#   time_zone   = "Asia/Kolkata"

#   config {
#     day = "MONDAY"
#     start_time {
#       hours   = 9
#       minutes = 0
#     }
#     end_time {
#       hours   = 17
#       minutes = 0
#     }
#   }
# }*/

data "aws_connect_queue" "cards_queues" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "ar_Cards_Queue"
  //max_contacts = "7"
}

data "aws_connect_queue" "fraud_queues" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "ar_Fraud_Queue"
  //max_contacts = "7"
}

# resource "aws_connect_queue" "test" {
#   instance_id           = "10cbce69-375a-4650-b14c-9b53be745e5a"
#   name                  = "ar_example_tf"
#   description           = "for terraform only"
#   hours_of_operation_id = aws_connect_hours_of_operation.office_hours.hours_of_operation_id
# }

# data "aws_connect_quick_connect" "existing_connect" {
#     instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
#     quick_connect_id = "8a56ed57-be3b-4ff0-826e-a83e2a564f8e" //cards quick connect
# }

# resource "aws_connect_quick_connect" "demo_quick" {
#     instance_id = "10cbce69-375a-4650-b14c-9b53be745e5a"
#     name = "demo_connect_bank"
#     description = "demo for banking only"
#     quick_connect_config {
#         quick_connect_type = "QUEUE"
#       queue_config {
#         queue_id = "3574601b-cffb-41db-8775-e84288dd8e82"
#         contact_flow_id = "416ae9d3-f6dd-4e00-bd62-8c4c3a49e79c"
#       }
#     }
# }


# variable "connect_instance_id" {
#   type        = string
# }

# # Step 1: Define the hierarchy levels
# resource "aws_connect_user_hierarchy_structure" "bank" {
#   instance_id = var.connect_instance_id
#   hierarchy_structure {
#     level_one {
#       name = "Department"
#     }
#     level_two {
#       name = "Team"
#     }
#     level_three {
#       name = "Role"
#     }
#   }
# }
# resource "aws_connect_user_hierarchy_group" "bank_department" {
#   instance_id = var.connect_instance_id
#   name        = "bank department"
#   depends_on = [
#     aws_connect_user_hierarchy_structure.bank
#   ]
# }
# resource "aws_connect_user_hierarchy_group" "banking_support" {
#   instance_id     = var.connect_instance_id
#   name            = "banking support"
#   parent_group_id = aws_connect_user_hierarchy_group.bank_department.hierarchy_group_id
# }
# resource "aws_connect_user_hierarchy_group" "senior_support" {
#   instance_id     = var.connect_instance_id
#   name            = "senior support"
#   parent_group_id = aws_connect_user_hierarchy_group.banking_support.hierarchy_group_id
# }

# output "movie_department_id" {
#   value = aws_connect_user_hierarchy_group.movie_department.hierarchy_group_id
# }

# output "booking_support_id" {
#   value = aws_connect_user_hierarchy_group.booking_support.hierarchy_group_id
# }

# output "senior_support_id" {
#   value = aws_connect_user_hierarchy_group.senior_support.hierarchy_group_id
# }
