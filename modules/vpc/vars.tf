variable "name" {
  type = string
  default =""
}

variable "cidr_block" {
    default = null
}

variable "private_subnet" {
  default = [""]
}
variable "public_subnet"{
  default = [""]
}
variable "availability_zone_private" {
  default = [""]
}
variable "availability_zone_public" {
  default = [""]
}
variable "tag" {
  type    = map
  default = {
    "Name" = "eks_cluster"
    "owner" = "eks_cluster"
    "purpose" = "assignment"
  }
}