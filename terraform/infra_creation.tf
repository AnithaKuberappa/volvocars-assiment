resource "aws_vpc" "demo_volvo" {
  cidr_block = "170.120.0.0/16"

}

resource "aws_subnet" "demo_subnet-1" {
  vpc_id                  = aws_vpc.demo_volvo.id
  cidr_block              = var.subnet1-cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_subnet-1"
  }

}

resource "aws_subnet" "demo_subnet1-2" {
  vpc_id                  = aws_vpc.demo_volvo.id
  cidr_block              = var.subnet2-cidr
  map_public_ip_on_launch = true
  tags = {
    Name = "demo_subnet-1"
  }

}

resource "aws_internet_gateway" "demo_igw" {
  vpc_id = aws_vpc.demo_volvo.id
  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "aws_rt" {
  vpc_id = aws_vpc.demo_volvo.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo_igw.id
  }

}

// assosiate subnet to routetable
resource "aws_route_table_association" "demo-rt_assocation" {
  subnet_id      = aws_subnet.demo_subnet.id
  route_table_id = aws_route_table.aws_rt.id

}
resource "aws_security_group" "demo_sg" {
  name        = "allow_tls"
  description = "allow TLS inbound traffic"
  vpc_id      = aws_vpc.demo_volvo.id

  ingress {
    description      = "TLS from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress = [{
    description      = "for all outgoing traffics"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    }
  ]
}

resource "aws_instance" "demo_server" {
  ami                    = "ami-03f4878755434977f"
  key_name               = "aws-ansible"
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.demo_subnet.id
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
}

