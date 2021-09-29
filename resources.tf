resource "aws_vpc" "EKS-VPC" {
    enable_dns_hostnames = true 
    enable_dns_support = true 
    cidr_block = "${var.VPCCIDR}"
    tags = {
        Name  = "${var.PROJECT}-${var.VPCNAME}-${var.ENV}"
        Owner = "${var.ResourceOwners}"
    }
}

resource "aws_internet_gateway" "InternetGateway" {
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.VPCNAME}-igw"
    }
}

resource "aws_subnet" "public-subnet1" {
    availability_zone  = "${var.AZ1}"
    map_public_ip_on_launch = true
    cidr_block = "${var.EKSPUB1}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPUBSUBNAME}-1"
    }
}

resource "aws_subnet" "public-subnet2" {
    availability_zone = "${var.AZ2}"
    map_public_ip_on_launch = true
    cidr_block = "${var.EKSPUB2}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPUBSUBNAME}-2"
    }
}

resource "aws_subnet" "public-subnet3" {
    availability_zone = "${var.AZ3}"
    map_public_ip_on_launch = true
    cidr_block = "${var.EKSPUB3}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPUBSUBNAME}-2"
    }
}

resource "aws_subnet" "private-subnet1" {
    availability_zone = "${var.AZ1}"
    map_public_ip_on_launch = false
    cidr_block = "${var.EKSPRI1}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPRISUBNAME}-1"
    }
}

resource "aws_subnet" "private-subnet2" {
    availability_zone = "${var.AZ2}"
    map_public_ip_on_launch = false
    cidr_block = "${var.EKSPRI2}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPRISUBNAME}-2"
    }
}

resource "aws_subnet" "private-subnet3" {
    availability_zone = "${var.AZ3}"
    map_public_ip_on_launch = false
    cidr_block = "${var.EKSPRI3}"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.EKSPRISUBNAME}-3"
    }
}

resource "aws_route_table" "pub-route-table" {
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.VPCNAME}-${var.EKSPUBRT}"
    }
}

resource "aws_route" "igwroute" {
    destination_cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.InternetGateway.id}"
    route_table_id = "${aws_route_table.pub-route-table.id}"
}

resource "aws_route_table" "pri-route-table" {
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.VPCNAME}-${var.EKSPRIRT}"
    }
}

resource "aws_route_table_association" "pub-sub-rt1" {
    route_table_id = "${aws_route_table.pub-route-table.id}"
    subnet_id = "${aws_subnet.public-subnet1.id}"
}

resource "aws_route_table_association" "pub-sub-rt2" {
    route_table_id = "${aws_route_table.pub-route-table.id}"
    subnet_id = "${aws_subnet.public-subnet2.id}"
}

resource "aws_route_table_association" "pub-sub-rt3" {
    route_table_id = "${aws_route_table.pub-route-table.id}"
    subnet_id = "${aws_subnet.public-subnet3.id}"
}


resource "aws_route_table_association" "pri-sub-rt1" {
    route_table_id = "${aws_route_table.pri-route-table.id}"
    subnet_id = "${aws_subnet.private-subnet1.id}"
}

resource "aws_route_table_association" "pri-sub-rt2" {
    route_table_id = "${aws_route_table.pri-route-table.id}"
    subnet_id = "${aws_subnet.private-subnet2.id}"
}

resource "aws_route_table_association" "pri-sub-rt3" {
    route_table_id = "${aws_route_table.pri-route-table.id}"
    subnet_id = "${aws_subnet.private-subnet3.id}"
}


resource "aws_security_group" "EKS-CP-SG" {
    description = "Security group for EKS Control Plane"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.VPCNAME}-control-plane-sg"
    }
}

resource "aws_security_group" "EKS-NODE-SG" {
    description = "Security group for EKS Data Plane"
    vpc_id = "${aws_vpc.EKS-VPC.id}"
    tags = {
        Name = "${var.PROJECT}-${var.VPCNAME}-data-plane-sg"
    }
}

resource "aws_security_group_rule" "control-self" {
    description = "Self-Reference"
    self = true
    security_group_id = "${aws_security_group.EKS-CP-SG.id}"
    #source_security_group_id = "${aws_security_group.EKS-CP-SG.id}"
    type = "ingress"
    from_port = "0"
    to_port = "65535"
    protocol = "-1" 
}

resource "aws_security_group_rule" "ControlPlaneToEKSNodes" {
    description = "Allow traffic from ControlPlane To EKSNodes"
    security_group_id = "${aws_security_group.EKS-NODE-SG.id}"
    source_security_group_id = "${aws_security_group.EKS-CP-SG.id}"
    type = "ingress"
    from_port = "0"
    to_port = "65535"
    protocol = "-1"
}


resource "aws_security_group_rule" "EKS-Nodes" {
    description = "Self-Reference"
    self = true
    security_group_id = "${aws_security_group.EKS-NODE-SG.id}"
    #source_security_group_id = "${aws_security_group.EKS-NODE-SG.id}"
    type = "ingress"
    from_port = "0"
    to_port = "65535"
    protocol = "-1"
}


resource "aws_security_group_rule" "EKSNodesTOControlPlane" {
    description = "Allow traffic from EKSNodes to control plane"
    security_group_id = "${aws_security_group.EKS-CP-SG.id}"
    source_security_group_id = "${aws_security_group.EKS-NODE-SG.id}"
    type = "ingress"
    from_port = "0"
    to_port = "65535"
    protocol = "-1"

}

