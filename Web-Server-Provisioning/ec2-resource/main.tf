resource "aws_instance" "web" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  vpc_security_group_ids      = [var.sg_id]
  key_name                    = var.key_name

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello from Terraform Web Server</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = var.instance_name
  }
}

resource "aws_eip" "web_ip" {
  instance = aws_instance.web.id
  vpc      = true
}


