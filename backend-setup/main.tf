
provider "aws" {
  region = "ap-south1"
}

resource "aws_s3_bucket" "terraform_state" {
bucket   = "sahil-terraform-state-bucket"
acl      = "private"

versioning {
  enabled=true
}

server_side_encyption_configuration {
rule {
 apply_server_side_encyption_bt_default {
  sse_algotithm  = "AES256"
}
}
}
  tags = {
     Name = "Terraform state Backent"
}
}
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "sahil-terraform-locks"
  biling_mode  = "PAY_PER_REQUEST"
  hash_key     ="LOCKID"

attribute  {
   name = "LOCKID"
   type  = "s"
}

tags = {
  Name = "Terraform LOCKS TABLW"
}
}

