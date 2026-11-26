
# Existing Amazon Connect Instance

data "aws_connect_instance" "existing" {
  instance_id = var.instance_id
}

# Existing User

data "aws_connect_user" "existing_user" {
  instance_id = data.aws_connect_instance.existing.id
  user_id     = "d9d26db8-1167-419a-8e09-65aed2e8da2e"
}

# Existing Queues

data "aws_connect_queue" "cards_queues" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "ar_Cards_Queue"
}

data "aws_connect_queue" "fraud_queues" {
  instance_id = data.aws_connect_instance.existing.id
  name        = "ar_Fraud_Queue"
}

# Existing Quick Connect

data "aws_connect_quick_connect" "existing_connect" {
  instance_id      = data.aws_connect_instance.existing.id
  quick_connect_id = "8a56ed57-be3b-4ff0-826e-a83e2a564f8e"
}

# Security Profile

resource "aws_connect_security_profile" "new_sp_demo" {
  instance_id = data.aws_connect_instance.existing.id

  name        = var.security_profile_name
  description = "For demo"

  permissions = [
    "BasicAgentAccess",
    "OutboundCallAccess",
    "CallRecordings"
  ]
}

# Routing Profile

resource "aws_connect_routing_profile" "new_routing" {
  instance_id = data.aws_connect_instance.existing.id

  name        = var.routing_profile_name
  description = "For demo only"

  default_outbound_queue_id = var.default_outbound_queue_id

  media_concurrencies {
    channel     = "VOICE"
    concurrency = 1

    cross_channel_behavior {
      behavior_type = "ROUTE_ANY_CHANNEL"
    }
  }

  queue_configs {
    channel  = "VOICE"
    delay    = 0
    priority = 1
    queue_id = var.fraud_queue_id
  }
}

# Connect User

resource "aws_connect_user" "demo_user" {
  instance_id = data.aws_connect_instance.existing.id

  name     = var.user_name
  password = var.user_password

  routing_profile_id = aws_connect_routing_profile.new_routing.id

  security_profile_ids = [
    aws_connect_security_profile.new_sp_demo.id
  ]

  identity_info {
    first_name = var.first_name
    last_name  = var.last_name
  }

  phone_config {
    after_contact_work_time_limit = 0
    phone_type                    = "SOFT_PHONE"
  }
}

# Quick Connect

resource "aws_connect_quick_connect" "demo_quick" {
  instance_id = data.aws_connect_instance.existing.id

  name        = var.quick_connect_name
  description = "Demo for banking only"

  quick_connect_config {
    quick_connect_type = "QUEUE"

    queue_config {
      queue_id        = var.fraud_queue_id
      contact_flow_id = var.contact_flow_id
    }
  }
}
