resource "aws_instance" "ec2_SSM" {
  ami           = "ami-06c68f701d8090592"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.subnet-public-01a.id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name      = "test"
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.iam_profile.name
  
  user_data = <<-EOF
              #!/bin/bash
              sudo yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
              sudo systemctl start amazon-ssm-agent
              EOF  

  tags = {
    Name = "ec2_SSM"
    Environment = "${var.environment}"
  }
}


