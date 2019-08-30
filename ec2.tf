
resource "aws_iam_instance_profile" "ec2_iam_profile" {
  name = "ec2_iam_profile"
  role = "${aws_iam_role.ec2_iam_role.name}"
}

resource "aws_iam_role" "ec2_iam_role" {
  name = "ec2_iam_role"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            },
            "Effect": "Allow",
            "Sid": ""
        }
    ]
}
EOF
}
resource "aws_iam_policy" "ec2_iam_role_deployer_policy" {
  name        = "ec2_iam_role_deployer_policy"
  description = "Policy to create a ec2_iam_role "
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect" : "Allow",
      "Action": [
        "autoscaling:*",
        "codedeploy:*",
        "kms:*",
        "codecommit:*",
        "codepipeline:*",
        "codebuild:*",
        "ec2:*",
        "lambda:*",
        "ecs:*",
        "elasticloadbalancing:*",
        "iam:*",
        "s3:*"
            ],
      "Resource": "*"
    }
   ]
}
EOF
}


resource "aws_iam_role_policy_attachment" "ec2_iam_role_deployer_policy" {
  policy_arn = "arn:aws:iam::270357824811:policy/ec2_iam_role_deployer_policy"
  role       = "${aws_iam_role.ec2_iam_role.name}"
}

