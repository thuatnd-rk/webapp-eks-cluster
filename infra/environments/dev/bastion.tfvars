bastion_config = {
  instance_type         = "t2.micro"
  allowed_ssh_cidr_blocks = ["101.99.12.144/32"]  # Replace with your IP for security
  root_volume_size      = 10
  tags = {
  }
}