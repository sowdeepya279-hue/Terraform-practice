variable "aws_region" {
  type = string
}

variable "identifier" {
  type = string
}

variable "engine" {
  type = string
}

variable "engine_version" {
  type = string
}

variable "instance_class" {
  type = string
}

variable "allocated_storage" {
  type = number
}

variable "max_allocated_storage" {
  type = number
}

variable "db_name" {
  type = string
}

variable "username" {
  type = string
}

variable "password" {      
  type      = string
  sensitive = true
}

variable "publicly_accessible" {
  type = bool
}

variable "multi_az" {
  type = bool
}

variable "tags" {
  type = map(string)
}