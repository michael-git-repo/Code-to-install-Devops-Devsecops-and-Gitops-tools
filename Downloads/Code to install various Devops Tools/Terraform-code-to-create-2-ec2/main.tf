terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# 1. Generate shared RSA private key
resource "tls_private_key" "shared_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# 2. Upload public key to AWS
resource "aws_key_pair" "shared_deploy_key" {
  key_name   = "shared-devops-key"
  public_key = tls_private_key.shared_key.public_key_openssh
}

# 3. Save PEM key directly to C:\Users\user\Downloads\shared-devops-key.pem
resource "local_file" "pem_file" {
  content  = tls_private_key.shared_key.private_key_pem
  filename = "C:/Users/${var.windows_user}/Downloads/shared-devops-key.pem"
}

# 4. Fetch Ubuntu 22.04 LTS AMI
data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"] # Canonical
}

# ==========================================
# 5. CUSTOM VPC NETWORKING SETUP
# ==========================================

# Custom VPC
resource "aws_vpc" "custom_vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "devops-custom-vpc"
  }
}

# Internet Gateway to allow traffic to/from the internet
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.custom_vpc.id

  tags = {
    Name = "devops-igw"
  }
}

# Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.custom_vpc.id
  cidr_block              = var.subnet_cidr
  map_public_ip_on_launch = true # Automatically assign public IPs to instances launched here

  tags = {
    Name = "devops-public-subnet"
  }
}

# Public Route Table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.custom_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "devops-public-route-table"
  }
}

# Route Table Association for Public Subnet
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# ==========================================
# 6. SECURITY GROUP
# ==========================================
resource "aws_security_group" "devops_sg" {
  name        = "devops-tools-sg"
  description = "Security group for DevOps toolchain, monitoring, web traffic, and SMTP"
  vpc_id      = aws_vpc.custom_vpc.id

  # SSH
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTP
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # HTTPS
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Grafana
  ingress {
    description = "Grafana"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Jenkins / ArgoCD
  ingress {
    description = "Jenkins / ArgoCD"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SonarQube
  ingress {
    description = "SonarQube"
    from_port   = 9000
    to_port     = 9000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Prometheus
  ingress {
    description = "Prometheus"
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Node Exporter
  ingress {
    description = "Node Exporter"
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Blackbox Exporter
  ingress {
    description = "Blackbox Exporter"
    from_port   = 9115
    to_port     = 9115
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Trivy Server
  ingress {
    description = "Trivy Server"
    from_port   = 4954
    to_port     = 4954
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTP
  ingress {
    description = "SMTP"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTPS
  ingress {
    description = "SMTPS"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # SMTP Submission
  ingress {
    description = "SMTP Submission"
    from_port   = 587
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "devops-security-group"
  }
}

# ==========================================
# 7. EC2 INSTANCES
# ==========================================

# EC2 Instance 1: Kubernetes EKS Server
resource "aws_instance" "eks_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.shared_deploy_key.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size           = 25
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Kubernetes EKS Server"
  }
}

# EC2 Instance 2: Monitoring Server
resource "aws_instance" "monitoring_server" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.shared_deploy_key.key_name
  subnet_id              = aws_subnet.public_subnet.id
  vpc_security_group_ids = [aws_security_group.devops_sg.id]

  root_block_device {
    volume_size           = 25
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "Monitoring"
  }
}

# ==========================================
# 8. ELASTIC IPS
# ==========================================

resource "aws_eip" "eks_eip" {
  domain     = "vpc"
  instance   = aws_instance.eks_server.id
  depends_on = [aws_internet_gateway.igw, aws_instance.eks_server]

  tags = {
    Name = "eks-server-eip"
  }
}

resource "aws_eip" "monitoring_eip" {
  domain     = "vpc"
  instance   = aws_instance.monitoring_server.id
  depends_on = [aws_internet_gateway.igw, aws_instance.monitoring_server]

  tags = {
    Name = "monitoring-eip"
  }
}