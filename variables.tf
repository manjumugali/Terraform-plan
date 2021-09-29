variable "bucket" {
    default = "bucket-name"
}

variable "sregion" {
    default = "us-east-1"
}

variable "key" {
    default = "terraform"
}

variable "aws_acceskey" {
    default = ""
}

variable "aws_secretkey" {
    default = ""
}
variable "region" {
    default = ""
}

variable "ENV" {
    type = string
    default = "prod"
}
variable "PROJECT" {
    type = string
    default = "test"
}

variable "VPCNAME" {
    type = string
    default = "eks" 
}

variable "VPCCIDR" {
    type = string
    default = "10.0.0.0/16"
}

variable "ResourceOwners" {
    type = string
    default = "Team-IPCPHOENIX"
}

variable "EKSPUBSUBNAME" {
    type = string
    default = "public-subnet"
}

variable "EKSPRISUBNAME" {
    type = string
    default = "private-subnet"
}

variable "EKSPUB1" {
    type = string
    default = "10.0.0.0/19"
}

variable "EKSPUB2"  {
    type = string
    default = "10.0.32.0/19"
}

variable "EKSPUB3" {
    type = string
    default = "10.0.64.0/19"
}

variable "EKSPRI1" {
    type = string
    default = "10.0.128.0/20"
}

variable "EKSPRI2" {
    type = string
    default = "10.0.144.0/20"
}

variable "EKSPRI3" {
    type = string
    default = "10.0.160.0/20"
}

variable "AZ1" {
    default = "ap-southeast-1a"
}

variable "AZ2" {
    default = "ap-southeast-1b"
}

variable "AZ3" {
    default = "ap-southeast-1c"
}

variable "EKSPUBRT" {
    default = "public-route-table"
}

variable "EKSPRIRT" {
    default = "private-route-table"
}

variable "EKSNODEVSIZE" {
    default = "30"
}

variable "EKSNODETYPE" {
    default = "t2.large"
}