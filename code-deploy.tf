data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

resource "aws_iam_role" "code-deploy" {
  name = "${var.project}-${var.name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_codedeploy_app" "app" {
  name = "${var.project}-${var.name}"
  compute_platform      = "Server"
}
##########################################################################################

resource "aws_codedeploy_deployment_config" "tata2019-code-deploy-dev" {
  deployment_config_name = "${var.project}-${var.name}-${var.environment}"

  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 2
  }
}

##########################################################################################################
# This policy allows to upload application revisions to S3 (if the S3 bucket arn is provided),
# register application revisions and trigger deployments on all deployment groups
# It's basically taken from the AWS documentation here
# http://docs.aws.amazon.com/codedeploy/latest/userguide/auth-and-access-control-iam-identity-based-access-control.html
resource "aws_iam_policy" "deployer_policy" {
  name        = "${var.project}-${var.name}-deployer-policy"
  description = "Policy to create a codedeploy application revision and to deploy it, for application ${aws_codedeploy_app.app.name}"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect" : "Allow",
      "Action": [
        "autoscaling:*",
        "codedeploy:*",
        "ec2:*",
        "lambda:*",
        "kms:*",
        "logs:*",
        "codebuild:*",
        "codecommit:*",
        "ecs:*",
        "elasticloadbalancing:*",
        "iam:AddRoleToInstanceProfile",
        "iam:CreateInstanceProfile",
        "iam:CreateRole",
        "iam:DeleteInstanceProfile",
        "iam:DeleteRole",
        "iam:DeleteRolePolicy",
        "iam:GetInstanceProfile",
        "iam:GetRole",
        "iam:GetRolePolicy",
        "iam:ListInstanceProfilesForRole",
        "iam:ListRolePolicies",
        "iam:ListRoles",
        "iam:PassRole",
        "iam:PutRolePolicy",
        "iam:RemoveRoleFromInstanceProfile", 
        "s3:*"
            ],
      "Resource": "*"
    },
{
      "Action": [
        "kms:DescribeKey",
        "kms:GenerateDataKey*",
        "kms:Encrypt",
        "kms:ReEncrypt*",
        "kms:Decrypt"
      ],
      "Resource": "${aws_kms_key.artifact_encryption_key.arn}",
      "Effect": "Allow"
    } 
   ]
}
EOF
}
resource "aws_iam_role_policy_attachment" "poc-code-deploy-deployer-policy" {
  policy_arn = "arn:aws:iam::270357824811:policy/poc-code-deploy-deployer-policy"
  role       = "${aws_iam_role.code-deploy.name}"
}

resource "aws_sns_topic" "poc-code-deploy-sns-topic" {
  name = "poc-code-deploy-sns-topic"
}

resource "aws_codedeploy_deployment_group" "deployment_group" {
  app_name              = "${var.project}-${var.name}"
  deployment_group_name = "${var.project}-${var.name}-${var.environment}"
  service_role_arn      = var.service_role_arn
  autoscaling_groups    = var.autoscaling_groups
  

   blue_green_deployment_config {
    deployment_ready_option {
      action_on_timeout = "CONTINUE_DEPLOYMENT"
    }


    terminate_blue_instances_on_deployment_success {
      action                           = "TERMINATE"
      termination_wait_time_in_minutes = 5
    }
  }
}
####################################################################################################
