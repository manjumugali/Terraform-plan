output "vpc_id" {
    value = "${aws_vpc.EKS-VPC.id}"
}

output "pub-subnet1" {
    value = "${aws_subnet.public-subnet1.id}"
}

output "pub-subnet2" {
    value = "${aws_subnet.public-subnet2.id}"
}

output "pub-subnet3" {
    value = "${aws_subnet.public-subnet3.id}"
}

output "pri-subnet1" {
    value = "${aws_subnet.private-subnet1.id}"
}

output "pri-subnet2" {
    value = "${aws_subnet.private-subnet2.id}"
}

output "pri-subnet3" {
    value = "${aws_subnet.private-subnet3.id}"
}
 output "sg-cp" {
     value = "${aws_security_group.EKS-CP-SG.id}"
}

output "sg-node" {
    value = "${aws_security_group.EKS-NODE-SG.id}"
}


locals {
  config_map_aws_auth = <<CONFIGMAPAWSAUTH


apiVersion: v1
kind: ConfigMap
metadata:
  name: aws-auth
  namespace: kube-system
data:
  mapRoles: |
    - rolearn: ${aws_iam_role.eks-nodes-role.arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
CONFIGMAPAWSAUTH

  kubeconfig = <<KUBECONFIG


apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.eks-cluster.endpoint}
    certificate-authority-data: ${aws_eks_cluster.eks-cluster.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${aws_eks_cluster.eks-cluster.name}"
KUBECONFIG
}

output "config_map_aws_auth" {
  value = local.config_map_aws_auth
}

output "kubeconfig" {
  value = local.kubeconfig
}
