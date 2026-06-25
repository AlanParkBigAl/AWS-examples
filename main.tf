terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_iam_group" "developers" {
  name = "DevelopmentTeam-tf"
}


resource "aws_iam_group_policy" "developer_s3_policy" {
  name  = "DeveloperS3Access-tf"
  group = aws_iam_group.developers.name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListAllMyBuckets",
          "s3:GetBucketLocation"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_user" "dev_user" {
  name = "dev-user-01-tf"
}


resource "aws_iam_user_group_membership" "team_binding" {
  user = aws_iam_user.dev_user.name

  groups = [
    aws_iam_group.developers.name
  ]
}

resource "aws_iam_user_login_profile" "user_login" {
  user                    = aws_iam_user.dev_user.name
  password_reset_required = true
}


resource "aws_iam_group" "admin_group" {
  name = "admin-tf"
}

resource "aws_iam_group_policy_attachment" "admin_attachment" {
  group      = aws_iam_group.admin_group.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


resource "aws_iam_account_password_policy" "strict_policy" {
  minimum_password_length        = 14
  require_lowercase_characters   = true
  require_uppercase_characters   = true
  require_numbers                = true
  require_symbols                = true
  allow_users_to_change_password = true
}


resource "aws_iam_role" "ec2_demo_role" {
  name = "DemoRoleForEC2-tf"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}


resource "aws_iam_role_policy_attachment" "role_policy_attach" {
  role       = aws_iam_role.ec2_demo_role.name
  policy_arn = "arn:aws:iam::aws:policy/IAMReadOnlyAccess"
}
