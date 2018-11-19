
terraform {
	backend "s3" { }
}

provider "aws" {
	region = "us-east-1"
}


module "mysql" {
    	source = "git::git@github.com:darraghog/terraform-examples-hello-world-modules.git//data-stores/mysql?ref=v0.0.1"

	db_name = "mysqlstage"
	allocated_storage = "10"
	db_password="${var.db_password}"
}
