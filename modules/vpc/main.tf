resource "aws_vpc" "eks_vpc" {
    cidr_block = var.cidr_block
    enable_dns_support   = true
    enable_dns_hostnames = true
    tags = {
          Name = "eks_cluster_vpc"
          owner = var.tag["owner"]
          purpose = var.tag["purpose"]
      }
}

resource "aws_subnet" "private" {
  count                   = length(var.private_subnet)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.private_subnet[count.index]
  availability_zone       = var.availability_zone_private[count.index]
  map_public_ip_on_launch = false
  tags = {
      Name = "private_subnet"
      owner = var.tag["owner"]
      purpose = var.tag["purpose"]
      "kubernetes.io/cluster/EKS_cluster_devops" = "shared"
  }
}
output "aws_subnet_private_id" {
  value = aws_subnet.private[*].id
}
resource "aws_subnet" "public" {
  count                   = length(var.public_subnet)
  vpc_id                  = aws_vpc.eks_vpc.id
  cidr_block              = var.public_subnet[count.index]
  availability_zone       = var.availability_zone_public[count.index]
  map_public_ip_on_launch = true
  tags = {
      Name = "public_subnet"
      owner = var.tag["owner"]
      purpose = var.tag["purpose"]

  }
}

resource "aws_internet_gateway" "eks_vpc_igw" {
 vpc_id = aws_vpc.eks_vpc.id
 tags = {
      Name = "eks_cluster_igw"
      owner = var.tag["owner"]
      purpose = var.tag["purpose"]
  }
}

resource "aws_route_table" "eks_vpc_rt_public" {
 vpc_id = aws_vpc.eks_vpc.id
  tags = {
      Name = "public_rt"
      owner = var.tag["owner"]
      purpose = var.tag["purpose"]
  }
}



resource "aws_route" "eks_vpc_public_route" {
  route_table_id         = aws_route_table.eks_vpc_rt_public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eks_vpc_igw.id
  depends_on             = [aws_route_table.eks_vpc_rt_public]
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "eks_subnet_association" {
  count                   = length(var.public_subnet)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.eks_vpc_rt_public.id
} 


