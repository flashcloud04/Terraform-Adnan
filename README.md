# AWS eCommerce Platform

This repository contains a Terraform-based AWS eCommerce platform designed for a Pluralsight sandbox environment. The architecture is intentionally modular, reusable, and suitable for a production-style deployment while remaining cost-aware.

## Architecture

The platform follows this layered design:

- Internet-facing ALB in public subnets
- Frontend EC2 Auto Scaling Group in private application subnets
- Internal ALB in private application subnets
- Backend EC2 Auto Scaling Group in private application subnets
- Multi-AZ MySQL RDS in private database subnets
- CloudWatch monitoring and log groups
- Secrets Manager for sensitive configuration
- IAM instance profiles for least-privilege EC2 access

## Network Design

The VPC is already provisioned and must not be destroyed or modified. The network uses:

- VPC CIDR: 10.0.0.0/16
- Public subnets: 10.0.1.0/24 and 10.0.2.0/24
- Private app subnets: 10.0.11.0/24 and 10.0.12.0/24
- Private DB subnets: 10.0.21.0/24 and 10.0.22.0/24
- NAT gateway for private subnet egress
- Internet gateway for public-tier access

The network segmentation keeps the Internet-facing ALB and frontend tier separate from the internal backend application servers and database.

## Security Groups

Security groups are split by responsibility and only allow the minimum traffic needed:

- Frontend ALB: inbound 80 from 0.0.0.0/0
- Frontend EC2: inbound 80 only from the frontend ALB security group
- Backend ALB: inbound 5000 only from the frontend EC2 security group
- Backend EC2: inbound 5000 only from the backend ALB security group
- RDS: inbound 3306 only from the backend EC2 security group

No public access is allowed to RDS or the backend tier.

## IAM and Secrets

The EC2 role is scoped for the least privilege required to:

- read AWS Secrets Manager values
- write logs and metrics to CloudWatch

The EC2 instances do not use AWS access keys and instead rely on IAM instance profiles.

Sensitive values are stored in Secrets Manager. Terraform state itself can contain secret values if passed in through variable files, so it must be protected with access controls and a secure backend configuration.

## RDS

The database is configured as MySQL in the private database subnets with:

- no public accessibility
- encryption at rest enabled
- automated backups enabled
- configurable deletion protection
- configurable final snapshot behavior
- configurable Multi-AZ deployment

## Auto Scaling and High Availability

The frontend and backend Auto Scaling Groups are configured across both private application subnets with a minimum of two instances and a maximum of four. The ASGs use ELB health checks and target tracking CPU policies to maintain availability and scale in response to utilization.

## Health Checks and Load Balancing

- Frontend ALB listens on port 80 and forwards to the frontend target group
- Backend ALB is internal and listens on port 5000
- Frontend health check uses HTTP port 80 with path /
- Backend health check uses HTTP port 5000 with path /health

The Nginx frontend proxies /api/* requests to the internal backend ALB DNS name.

## CloudWatch

CloudWatch monitors:

- frontend ASG CPU utilization
- backend ASG CPU utilization
- ALB unhealthy host counts
- RDS CPU, storage, and connection metrics
- application log groups for frontend and backend logs

Retentions are kept to a reasonable sandbox duration.

## Directories

- terraform/modules: reusable infrastructure modules
- terraform/environments/dev: development environment wiring
- terraform/environments/test: template for future test environment reuse
- terraform/userdata: EC2 user-data scripts for frontend and backend initialization

## How to Use

1. Define environment secrets in a secure tfvars or secret injection process.
2. Update the backend S3 bucket name in the environment backend configuration.
3. Run:
   - terraform fmt -recursive
   - terraform init
   - terraform validate
   - terraform plan
4. Do not run terraform apply or terraform destroy without explicit approval.

## Troubleshooting

- If Terraform reports missing variables, provide the required values via tfvars or environment variables.
- If RDS or security group settings conflict with an existing environment, adjust the configuration rather than deleting the network.
- If the backend app health check does not pass, verify the Flask service is listening on 0.0.0.0:5000 and the /health endpoint returns HTTP 200.
- If Nginx proxying fails, confirm the backend ALB DNS name is passed correctly to the frontend userdata script.

## Notes

This repository intentionally avoids ECS, Fargate, Docker, Route53, ACM, CloudFront, WAF, and GitHub Actions for now. The current goal is the complete reproducible AWS infrastructure path described above.
