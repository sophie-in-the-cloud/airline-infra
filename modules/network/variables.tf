variable "prefix" {
  description = "리소스 이름 접두사"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs" {
  description = "사용할 가용영역 리스트"
  type        = list(string)
}

variable "public_subnets" {
  description = "퍼블릭 서브넷 CIDR"
  type        = list(string)
}

variable "private_subnets" {
  description = "프라이빗 서브넷 CIDR"
  type        = list(string)
}