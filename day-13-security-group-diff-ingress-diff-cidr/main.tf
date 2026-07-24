resource "aws_security_group" "diff_cidr" {
  name        = "devops-sow"
  description = "sg for devops project"

#Dynamic ingress rules for multiple ports
   dynamic "ingress" {
     for_each = var.cidr_port_map
      content {
      description      = "inbound rules"
      from_port        = ingress.value.from_port
      to_port          = ingress.value.to_port
      protocol         = ingress.value.protocol
      cidr_blocks      = ingress.value.cidr_blocks
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  
}
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-project-sow"
  }
}