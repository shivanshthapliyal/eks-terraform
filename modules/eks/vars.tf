variable "aws_eks_cluster_name" {
  default = "EKS_cluster_devops"
}
variable "node_group_name" {
  default = "EKS_node_group_devops"
}
variable "role_arn" {
  default = ""
}
variable "subnet_ids"{
  default = null
}

variable "node_role_arn" {
  default = null
}

variable "cluster_policy" {
  default = null
}
variable "service_policy" {
  default = null
}

variable "example-AmazonEKSClusterPolicy" {
  default = null
}

variable "example-AmazonEKSServicePolicy" {
  default = null
}

