# AWS IAM Automation Project
Author: Alan Park

Project Overview
This project demonstrates the automation of AWS Identity and Access Management (IAM) resources using Terraform. As part of my preparation for the AWS Solutions Architect Associate (SAA) certification, I transitioned from manual console configuration to Infrastructure as Code (IaC) best practices to enhance security and deployment efficiency.

Resources Managed
This configuration automates the creation and binding of:

IAM Users and Login Profiles

IAM Groups with attached permissions

IAM Roles with EC2 trust relationships

Account-level Password Policies

Key Security Practices
Least Privilege: Implemented specific S3 read-only policies rather than broad administrative access.

Automation: Utilized jsonencode() for policy management to ensure consistent, repeatable security configurations.

Governance: Enforced strict account-wide password policies via Terraform.

Project Evidence
Infrastructure Lifecycle: Validated deployment with terraform plan and successfully applied via terraform apply.

Verification: Resources were audited and verified directly within the AWS Management Console to confirm policy and role attachment accuracy.
