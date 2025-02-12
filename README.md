# AWS RDS with Terraform

This repository contains Terraform configurations to set up an AWS RDS MySQL instance with proper networking and security configurations.

## Prerequisites

- AWS CLI configured with appropriate credentials
- Terraform installed
- MySQL client or MySQL Workbench for database access

## Setup

1. Clone the repository
2. Copy `terraform.tfvars.example` to `terraform.tfvars`
3. Update the variables in `terraform.tfvars` with your values
4. Initialize Terraform:
   ```bash
   terraform init
   ```
5. Apply the configuration:
   ```bash
   terraform apply
   ```

## Infrastructure Components

- VPC with proper networking setup
- Private subnets in different availability zones
- Security group for RDS access
- RDS instance with MySQL 8.4.3
- CloudWatch logs integration
- Automated backups enabled

## Variables

| Name | Description | Type | Default |
|------|-------------|------|---------|
| environment | Environment name | string | "dev" |
| instance_class | RDS instance class | string | "db.t3.micro" |
| allocated_storage | Allocated storage in GB | number | 20 |
| database_name | Name of the database | string | "myapp" |
| database_username | Database master username | string | "admin" |
| database_password | Database master password | string | (required) |
| my_ip | Your public IP address | string | (required) |

## Outputs

- `rds_endpoint`: The endpoint URL of the RDS instance
- `rds_port`: The port number of the RDS instance
- `database_name`: The name of the created database
- `database_username`: The master username for the database

## Connecting to the Database

Use MySQL Workbench or the MySQL command line client:

```bash
mysql -h <rds_endpoint> -P <rds_port> -u <database_username> -p <database_name>
```

## Security Considerations

- The RDS instance is created in private subnets
- Access is restricted to the VPC and your IP address
- Database password should be kept secure and not committed to version control
- Update the security group if your IP address changes

## Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a new Pull Request