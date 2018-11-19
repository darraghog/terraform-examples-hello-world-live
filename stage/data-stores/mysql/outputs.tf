
output "db_port" {
	value = "${module.mysql.db_port}"
}

output "db_address" {
	value = "${module.mysql.db_address}"
}

# NB: store password in tfstate for convenience
# Replace with KMS in future
output "db_password" {
	value = "${module.mysql.db_password}"
}


