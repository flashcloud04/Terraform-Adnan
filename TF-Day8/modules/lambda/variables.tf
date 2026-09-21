variable "function_name" {
  type = string
}

variable "lambda_role_arn" {
  type = string
}

variable "source_file" {
  type = string
}

variable "handler" {
  type    = string
  default = "app.lambda_handler"
}

variable "runtime" {
  type    = string
  default = "python3.12"
}

variable "timeout" {
  type    = number
  default = 30
}

variable "memory_size" {
  type    = number
  default = 128
}

variable "tags" {
  type    = map(string)
  default = {}
}
