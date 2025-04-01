locals {
  common_tags = {
    CreatedBy = "Terraform"
    Team      = "DevOps"
    UserType  = "User"
  }
}
locals {
  service_tags = {
    CreatedBy = "Terraform"
    Team      = "DevOps"
    UserType  = "service"
  }
}
