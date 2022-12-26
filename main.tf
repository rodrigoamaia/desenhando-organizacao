provider "googleworkspace" {
  credentials             = "${file("serviceaccount.yaml")}"
  customer_id             = "xxxxxxxx"
  impersonated_user_email = "rodrigoamaia@rodrigo-devops-gcp.com.br"
  oauth_scopes = [
    "https://www.googleapis.com/auth/admin.directory.user",
    "https://www.googleapis.com/auth/admin.directory.userschema",
    "https://www.googleapis.com/auth/admin.directory.group",	
    # include scopes as needed
  ]
}

resource "googleworkspace_group" "devops" {
  email       = "rodrigoamaia@rodrigo-devops-gcp.com.br"
  name        = "Devops"
  description = "Devops Group"

  aliases = ["dev-ops@rodrigo-devops-gcp.com.br"]

  timeouts {
    create = "1m"
    update = "1m"
  }
}

resource "googleworkspace_user" "rodrigo" {
  primary_email = "rodrigoamaia@rodrigo-devops-gcp.com.br"
  password      = "34819d7beeabb9260a5c854bc85b3e44"
  hash_function = "MD5"

  name {
    family_name = "Rodrigo"
    given_name  = "Maia"
  }
}

resource "googleworkspace_group_member" "manager" {
  group_id = googleworkspace_group.devops.id
  email    = googleworkspace_user.rodrigo.primary_email

  role = "MANAGER"
}