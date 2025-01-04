variable "ami" {
  default     = "ami-0acc77abdfc7ed5a6"
  description = "OS that my ec2 will be running on"
}

variable "region" {
  default     = "eu-west-2"
  description = "where will my EC2 live?"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "storage and operating power"
}

variable "pem" {
  default = "backend"
}

variable "known_ips" {
  type = list(string)
  default = [
    "86.156.185.83/32",
    "213.32.248.64/32"
  ]
}