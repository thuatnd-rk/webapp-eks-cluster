resource "aws_security_group" "rds" {
  name        = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-rds-sg"
  description = "Security group for RDS instance"
  vpc_id      = var.vpc_id

  ingress {
    description     = "PostgreSQL from bastion host"
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [var.bastion_security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    {
      Name = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-rds-sg"
    },
    var.rds_config.tags
  )
}

resource "aws_db_parameter_group" "this" {
  name        = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-rds-pg"
  family      = "postgres13"
  description = "RDS parameter group for PostgreSQL"

  tags = merge(
    {
      Name = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-rds-pg"
    },
    var.rds_config.tags
  )
}

resource "aws_db_subnet_group" "this" {
  name        = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-subnet-group"
  description = "Subnet group for ${var.rds_config.name != null ? var.rds_config.name : "postgres"} RDS instance"
  subnet_ids  = var.subnet_ids

  tags = merge(
    {
      Name = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-subnet-group"
    },
    var.rds_config.tags
  )
}

resource "aws_db_instance" "this" {
  identifier              = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}"
  engine                  = "postgres"
  engine_version          = var.rds_config.engine_version
  instance_class          = var.rds_config.instance_class
  allocated_storage       = var.rds_config.allocated_storage
  max_allocated_storage   = var.rds_config.max_allocated_storage
  storage_type            = "gp3"
  storage_encrypted       = true
  username                = var.rds_config.username
  password                = var.rds_password
  port                    = 5432
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = [aws_security_group.rds.id]
  parameter_group_name    = aws_db_parameter_group.this.name
  backup_retention_period = var.rds_config.backup_retention_period
  skip_final_snapshot     = var.rds_config.skip_final_snapshot
  final_snapshot_identifier = "${var.rds_config.name != null ? var.rds_config.name : "postgres"}-final-snapshot"
  multi_az                = var.rds_config.multi_az
  publicly_accessible     = false
  tags = var.rds_config.tags
}