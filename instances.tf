##################################################################################
# DATA
##################################################################################

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical

}

##################################################################################
# RESOURCES
##################################################################################

# RANDOM
resource "random_id" "server" {
  byte_length = 4
}


# KEY PAIRS
resource "aws_key_pair" "ubuntu" {
  key_name   = var.key_pair_name
  public_key = var.public_key
}

# INSTANCES #
resource "aws_instance" "web_server" {
  ami                    = nonsensitive(data.aws_ami.ubuntu.id)
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.front_sub1.id
  vpc_security_group_ids = [aws_security_group.web_server_sg.id]
  key_name               = aws_key_pair.ubuntu.key_name
  user_data = "${data.cloudinit_config.web_server.rendered}"

  tags = {
    Name = "tsanghan-ce6-${local.random.Name}"
  }

}