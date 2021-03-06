terraform {
	backend "s3" {}
}

provider "aws" {
  region = "us-east-1"
}

data "terraform_remote_state" "db" {
        backend="s3"
        config {
                bucket="${var.db_remote_state_bucket}"
                key="${var.db_remote_state_key}"
                region="${var.region}"
        }
}

module "webserver_cluster" {
  source = "git::git@github.com:darraghog/terraform-examples-hello-world-modules.git//services/webserver-cluster?ref=v0.0.1" 
 
  cluster_name           = "webservers-prod"
  db_remote_state_bucket = "${var.db_remote_state_bucket}"
  db_remote_state_key    = "${var.db_remote_state_key}"
  db_port = "{$data.terraform_remote_state.db.db_port}"
  db_address = "${data.terraform_remote_state.db.db_address}"
  instance_type = "t2.micro"
  max_size = 10
  min_size = 2
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = "${module.webserver_cluster.elb_security_group_id}"

  from_port   = 12345
  to_port     = 12345
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
