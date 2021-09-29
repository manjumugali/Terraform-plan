terraform {
    backend "s3" {}
}
data "terraform_remote_state" "state" {
    backend = "s3"
    config = {
       bucket = "${var.bucket}"
       region = "${var.sregion}"
       key    = "${var.key}"
    }
}