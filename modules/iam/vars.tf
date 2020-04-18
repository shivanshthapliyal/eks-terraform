variable "name" {
  type = map
  default = {
      cluster = "eks_cluster_devops"
      node = "eks_node_devops"
  }
}
