resource "aws_instance" "foo" {
  ami           = var.ami # us-west-2
  instance_type = var.instance_type
  key_name      = var.key_pair

  security_groups = [aws_security_group.jenkins_sg.name]

  user_data = file("${path.module}/scripts/setup.sh")
}

resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_sg"

  vpc_id = data.aws_vpc.default_vpc.id
  ingress{
    from_port = 8080
    protocol = "TCP"
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress{
    from_port = 22
    protocol = "TCP"
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress{
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}