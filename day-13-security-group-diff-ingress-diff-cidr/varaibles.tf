variable "cidr_port_map" {
  type = map(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
  
  default = {
    ssh = {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"] 
    }

    http = {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    https = {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    app3000 = {
      from_port   = 3000
      to_port     = 3000
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.25/32"]
    }

    app8080 = {
      from_port   = 8080
      to_port     = 8080
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.25/32"]
    }

    app8081 = {
      from_port   = 8081
      to_port     = 8081
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.25/32"]
    }

    app8082 = {
      from_port   = 8082
      to_port     = 8082
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.25/32"]
    }

    sonar = {
      from_port   = 9000
      to_port     = 9000
      protocol    = "tcp"
      cidr_blocks = ["203.0.113.25/32"]
    }
  }
}