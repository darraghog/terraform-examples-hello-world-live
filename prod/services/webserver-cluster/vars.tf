variable "db_remote_state_bucket" {
  description = "The name of the S3 bucket used for the database's remote state storage"
  default="darraghog-terraform-up-and-running-state-us-east-1"
}

variable "db_remote_state_key" {
  description = "The name of the key in the S3 bucket used for the database's remote state storage"
  default="prod/data-stores/mysql/terraform.tfstate"
}

variable "region" {
	description="Name of region to deploy to and where state is maintained"
	default="us-east-1"
}
