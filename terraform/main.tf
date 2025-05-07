resource "aws_key_pair" "mykey" {
  key_name   = var.key_name
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQC84EN3+tHVhh64Bk2zqWX81p6vM9qlYxOTTCWrdmia73mi9VcqwdsSXnfffxHuhESksJQ8B8p889gWm5GwsAyKjg52catJcBwGB/uN3kFN+HLtDDWpkbED38i3SEI3+tDdtrwQoTbDF+TLaebszmX2zr47qDkf0VoEoQP3GePoZke9ryCNurYKVMV9rA5Ew9xqx79xm/Kb5J4I3yliqjUy2It7/nD+dbY0um3XrrrYFGi44GedsxMJ09Uou7qiHmDMy46E2wVtsiKuUZETyN9vyXnNeKBoLJ8UHqpVj+vgtj4mRFFxeS1wthl8Czytv93NG9sw0fB7bmniLpnR1r6WjMsGtEFa9CJOXg9f45gNiVVZf7+/4d+bQapJmdp5cn/GoCAHX3QPg+SRzBp/bh9kDMDAoEcnpKrgAaWYOt1TsBQMBv6ziplE4jocrRikE8BMmc3yUMKrsuGhv1Yv4btUoWYfqYSBnQWeRb+6j8dpzNu7+krRB7zXp77IyTDcBw1fXbw4TA/AYwVuyqInLsuJcpXNPzcka6lFJ5LTz8vkLfWNXrav32Kfk4S8mueJ6mKVzCz1fcy2xTAvZJ8I7h3J8C2lzLZTazHqMUfWDKB59mMl3TA8uSLUy5oUMi4yxdWFrlAMyMTSWLorT6UlTrHCVOtLVcGQCjmu9lK0FRNmuQ== dimakovgan911@gmail.com"
}







variable "region" {
  description = "AWS region"
}

resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Allow HTTP"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
ingress {
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web_app" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.mykey.key_name
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              # Force update $(date +%s)
              sudo apt update -y
              sudo apt install docker.io -y
              sudo systemctl start docker
              sudo docker run -d -p 80:80 dimakovgan/lab4:latest
              EOF

  tags = {
    Name = "Lab6-Instance"
  }
}