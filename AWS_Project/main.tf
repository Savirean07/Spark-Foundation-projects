resource "aws_vpc" "main" {
 
  instance_tenancy = "default"
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "main"
  }
}
resource "aws_subnet" "main" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.1.0/24"
  # region = "ap-south-1"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Main"
  } 
}
resource "aws_network_acl" "main" {
  vpc_id = "${aws_vpc.main.id}"
# region = "ap-south-1"
  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "${aws_subnet.main.cidr_block}"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "${aws_subnet.main.cidr_block}"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "main"
  }
}
resource "aws_security_group" "lb_sg" {
  name        = "allow_tls_sg"
  description = "Allow TLS traffic"
  vpc_id      = aws_vpc.main.id
# region = "ap-south-1"
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]  # Convert to a list with single element
  }
}
resource "aws_lb" "test" {
  name               = "test-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.lb_sg.id]
  enable_deletion_protection = false
  subnets            = [aws_subnet.main.id , aws_subnet.main2.id]


  tags = {
    Environment = "production"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-0ded8326293d3201b"
  instance_type = "t2.micro"
key_name = "test2"
subnet_id = "${aws_subnet.main.id}"
  # Other instance configuration parameters...
}
resource "aws_subnet" "main2" {
  vpc_id     = "${aws_vpc.main.id}"
  cidr_block = "10.0.64.0/24"
  # region = "ap-south-1"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "Main"
  } 
}

resource "aws_instance" "test2" {
  ami           = "ami-0ded8326293d3201b"
  instance_type = "t2.micro"
key_name = "test2"
subnet_id = "${aws_subnet.main2.id}"
  # Other instance configuration parameters...
}
resource "aws_s3_bucket" "example" {
  bucket = "testingbucketfrom"

}


