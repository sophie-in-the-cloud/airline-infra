variable "vpc_cidr" {
  type    = string
  default = "10.20.0.0/16"
}

variable "azs" {
  type    = list(string)
  default = ["ap-northeast-2a", "ap-northeast-2c"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["10.20.1.0/24", "10.20.2.0/24"]
}


variable "private_subnets" {
  type = list(string)
  default = [
    "10.20.3.0/24",
    "10.20.4.0/24",
    "10.20.5.0/24",
    "10.20.6.0/24",
    "10.20.7.0/24",
    "10.20.8.0/24"
  ]
}
