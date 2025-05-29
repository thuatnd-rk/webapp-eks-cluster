# Microservices Platform on AWS EKS

## Overview
This is a modern microservices-based platform deployed on Amazon EKS (Elastic Kubernetes Service). The platform consists of multiple microservices that handle different aspects of the business, including user management, order processing, payments, messaging, file uploads, and a dashboard interface.

## Project Structure
```
webapp-eks-cluster/
├── ci-cd/           # CI/CD pipeline configurations
├── charts/          # Helm charts for Kubernetes deployments
├── docs/            # Project documentation and runbooks\
├── images/          # Images using in repository
├── infra/           # Infrastructure as Code (Terraform)
├── platform/        # Platform-specific configurations
└── source-code/     # Microservices source code
    ├── dashboard/   # Admin dashboard application
    ├── user/        # User management service
    ├── order/       # Order processing service
    ├── payment/     # Payment processing service
    ├── message/     # Messaging service
    └── upload/      # File upload service
```

## Infrastructure
The infrastructure is managed using Terraform and includes:

- **VPC**: Custom VPC with public and private subnets
- **EKS Cluster**: Kubernetes cluster for running microservices
- **RDS**: PostgreSQL database for data persistence
- **ACM**: SSL/TLS certificates for secure communication
- **Bastion Host**: Secure access point for administrative tasks
- **Security Groups**: Network security configurations

## Microservices Architecture
The platform follows a microservices architecture with the following components:

1. **Dashboard**: Admin interface for system management
2. **User Service**: User management and authentication service
3. **Order Service**: Order processing and management service
4. **Payment Service**: Payment processing and transaction management
5. **Message Service**: Messaging and notification service
6. **Upload Service**: File upload and storage service

## Getting Started

### Prerequisites
- AWS Account with appropriate permissions
- Terraform installed
- kubectl configured
- AWS CLI configured
- Helm installed

### Infrastructure Setup
1. Navigate to the `infra` directory
2. Initialize Terraform:
   ```bash
   terraform init
   ```
3. Apply the infrastructure:
   ```bash
   terraform apply
   ```

### Application Deployment
1. Configure kubectl to use the EKS cluster
2. Deploy the applications using Helm charts from the `charts` directory

## Development
- Each microservice is developed independently in the `source-code` directory
- Follow the microservices architecture guidelines in the `docs` directory
- Use the provided CI/CD pipelines for automated testing and deployment

## Documentation
- Architecture documentation: `docs/architecture.md`
- Runbooks: `docs/runbooks/`
- Infrastructure documentation: `infra/README.md`