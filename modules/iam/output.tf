output "aws_iam_role" {
  value = aws_iam_role.cluster.arn
}

output "node_role_arn" {
  value = aws_iam_role.node.arn
}

output "example-AmazonEKSClusterPolicy" {
  value = aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy
}

output "example-AmazonEKSServicePolicy" {
  value = aws_iam_role_policy_attachment.example-AmazonEKSServicePolicy
}