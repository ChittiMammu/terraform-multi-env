resource "aws_security_group" "allow_ssh" {

  name = "allow_ssh"
  description = "allow number 22 port"
  
  ingress {
    from_port        = "22"
    to_port          = "22"
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  
  }

  tags = {
    Name = "allow_ssh"
    CreatedBy = "mamatha"
    
  }
}


resource "aws_instance" "expense" {
    for_each = var.instance_names # each.key and each.value
    ami = "ami-090252cbe067a9e58"
    vpc_security_group_ids = ["sg-01d1a14f4aa4ce4c9"] # replace with you SG ID
    instance_type = each.value
    tags = merge(
        var.common_tags,
        {
            Name = "${each.key}"
            Module = "${each.key}"
            Environment = var.environment
        }
    )
}

resource "aws_route53_record" "expense" {
  for_each = aws_instance.expense
  zone_id = var.zone_id
  name    = each.key == "frontend-prod" ? var.domain_name : "${each.key}.${var.domain_name}"
  type    = "A"
  ttl     = 1
  records = startswith(each.key, "frontend") ? [each.value.public_ip] : [each.value.private_ip]
  # if records already exists
  allow_overwrite = true
}