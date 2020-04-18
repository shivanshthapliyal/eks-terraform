
resource "aws_eks_cluster" "self" {
  name     = var.aws_eks_cluster_name
  role_arn = var.role_arn

  vpc_config {
    subnet_ids = var.subnet_ids
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy,
  # ]
   depends_on = [
    var.example-AmazonEKSClusterPolicy,
    var.example-AmazonEKSServicePolicy,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.self.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.self.certificate_authority.0.data
}


resource "aws_eks_node_group" "self" {
  cluster_name    = aws_eks_cluster.self.name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  # depends_on = [
  #   aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
  #   aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
  #   aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  # ]
}