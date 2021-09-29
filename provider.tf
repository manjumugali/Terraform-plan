provider "aws" {
  access_key = "${var.aws_acceskey}"
  secret_key = "${var.aws_secretkey}"
  region     = "${var.region}"   
}