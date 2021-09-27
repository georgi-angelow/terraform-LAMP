resource "aws_key_pair" "example" {
  key_name   = "example-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
  }

resource "aws_instance" "my_web_instance" {
  ami                    = var.ami
  instance_type          = "t2.large"
  key_name               = aws_key_pair.example.key_name
  subnet_id              = aws_subnet.main.id
  security_groups        = [aws_security_group.allow_inbound_http.id , aws_security_group.allow_outbound_traffic.id]
  tags = {
    Name = "my_web_instance"
  }
  volume_tags = {
    Name = "my_web_instance_volume"
  }
  provisioner "remote-exec" { #install apache, mysql client, php
    inline = [
        "sudo mkdir -p /var/www/html/",
        "sudo yum update -y",
        "sudo yum install -y httpd",
        "sudo service httpd start",
        "sudo usermod -a -G apache ec2-user",
        "sudo chown -R ec2-user:apache /var/www",
        "sudo yum install -y mysql php php-mysql"
    ]
}
  provisioner "file" { #copy the index file form local to remote
    source      = "index.php"
    destination = "/var/www/html/index.php"
  }
  
  provisioner "remote-exec" { 
    inline = [
        "sudo service httpd restart"
    ]
  }
  
  connection {
    type = "ssh"
    user = "ec2-user"
    password = ""
    host        = aws_instance.my_web_instance.public_dns
    private_key = file("id_rsa")
    }
}