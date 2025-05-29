#!/bin/bash

# Usage: ./terraform.sh [env] [action]
# Example: ./terraform.sh dev apply
# The RDS_PASSWORD environment variable must be set before running this script

set -e

ENV=$1
ACTION=$2

if [[ -z "$ENV" || -z "$ACTION" ]]; then
  echo "Usage: ./terraform.sh [dev|prod] [plan|apply|destroy]"
  exit 1
fi

if [[ -z "$RDS_PASSWORD" ]]; then
  echo "Error: RDS_PASSWORD environment variable is not set."
  echo "Please set it before running this script. For example:"
  echo "  export RDS_PASSWORD='your-secure-password'"
  echo "  or"
  echo "  RDS_PASSWORD='your-secure-password' ./terraform.sh $ENV $ACTION"
  exit 1
fi

REGION_VARS="environments/$ENV/region.tfvars"
ACM_VARS="environments/$ENV/acm.tfvars"
VPC_VARS="environments/$ENV/vpc.tfvars"
EKS_VARS="environments/$ENV/eks.tfvars"
BASTION_VARS="environments/$ENV/bastion.tfvars"
RDS_VARS="environments/$ENV/rds.tfvars"
BACKEND_CONFIG="environments/$ENV/backend.config"


echo ">>> Initializing Terraform with backend config from $BACKEND_CONFIG..."
terraform init -backend-config="$BACKEND_CONFIG"

echo ">>> Running 'terraform $ACTION' with tfvars from $REGION_VARS,$ACM_VARS, $VPC_VARS, $EKS_VARS, $BASTION_VARS, $RDS_VARS..."
terraform "$ACTION" \
  -var-file="$REGION_VARS" \
  -var-file="$ACM_VARS" \
  -var-file="$VPC_VARS" \
  -var-file="$EKS_VARS" \
  -var-file="$BASTION_VARS" \
  -var-file="$RDS_VARS" \
  -var="rds_password=$RDS_PASSWORD"