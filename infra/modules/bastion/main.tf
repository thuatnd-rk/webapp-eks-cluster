resource "aws_security_group" "bastion" {
  name        = "${var.bastion_config.name != null ? var.bastion_config.name : "bastion"}-sg"
  description = "Security group for bastion host"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from allowed IP ranges"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.bastion_config.allowed_ssh_cidr_blocks
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.bastion_config.name != null ? var.bastion_config.name : "bastion"}-sg"
    },
    var.bastion_config.tags
  )
}

resource "aws_instance" "bastion" {
  ami                         = var.ami_id
  instance_type               = var.bastion_config.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.bastion.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true

  root_block_device {
    volume_size = var.bastion_config.root_volume_size
    volume_type = "gp3"
  }

  tags = var.bastion_config.tags
}