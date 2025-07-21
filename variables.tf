variable "custom_port" {
  description = "Port for inbound traffic"
  type        = number
  default     = 1234  # Replace with last 4 digits of your roll no
}

variable "key_name" {
  description = "Name of the AWS key pair"
  type        = string
}
