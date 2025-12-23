variable "instance_type" {
  description = "Please enter your instanse_type"
  type = string
  default = "t3.micro"
}

variable "environment" {
  description = "Your Environment"
  type = string
  default = "DEV"
}

variable "instance_name" {
  description = "Your instance_name"
  type = string
  default = "saradhi-test"
}