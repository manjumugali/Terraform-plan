resource "aws_iam_role" "eks-cp-role" {
    name = "${var.PROJECT}-${var.VPCNAME}-control-plane-role"
    assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "eks-cp-managed-policy-1" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
    role = "${aws_iam_role.eks-cp-role.name}"
}

resource "aws_iam_role_policy_attachment" "eks-cp-managed-polity-2" {
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
    role = "${aws_iam_role.eks-cp-role.name}"
}

resource "aws_eks_cluster" "eks-cluster" {
    name = "${var.PROJECT}-${var.VPCNAME}-cluster"
    role_arn = "${aws_iam_role.eks-cp-role.arn}"
    vpc_config {
        subnet_ids = ["${aws_subnet.public-subnet1.id}","${aws_subnet.public-subnet2.id}","${aws_subnet.public-subnet3.id}"]
        security_group_ids = ["${aws_security_group.EKS-CP-SG.id}"]
    }

    depends_on = [
        aws_iam_role_policy_attachment.eks-cp-managed-policy-1,
        aws_iam_role_policy_attachment.eks-cp-managed-polity-2
    ]

}