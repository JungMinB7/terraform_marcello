variable "cluster_name" {
  description = "EKS 클러스터 이름"
  type        = string
}

variable "subnet_ids" {
  description = "EKS가 사용할 서브넷 ID 리스트"
  type        = list(string)
}
