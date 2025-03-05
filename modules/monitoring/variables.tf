variable "eks_cluster" {}
variable "vpc_id" {}
variable "subnet_ids" {
  type = list(string)
}
variable "environment" {}