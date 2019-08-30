variable "aws_region" {
  description = "Region for the VPC"
  default = "us-west-2"
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  default = "10.0.0.0/16"
}

variable "public1_subnet_cidr" {
  description = "CIDR for the public subnet1"
  default = "10.0.1.0/24"
}


variable "public2_subnet_cidr" {
  description = "CIDR for the public subnet2"
  default = "10.0.2.0/24"
}


variable "db_subnet1_cidr" {
  description = "CIDR for the private subnet1"
  default = "10.0.3.0/24"
}


variable "db_subnet2_cidr" {
  description = "CIDR for the private subnet2"
  default = "10.0.4.0/24"
}

variable "ami" {
  description = "Amazon Linux AMI"
  default = "ami-0aea13229426c207b"
}

variable "key_path" {
  description = "SSH Public Key path"
  default = "public_key"
}

variable "subnet_cidrs_public" {
  description = "Subnet CIDRs for public subnets"
  default = ["10.0.1.0/24", "10.0.2.0/24"]
  type = "list"
}

variable "ami_id" {
    description = "The AMI ID for AWS Linux 2 in us-west-2.eg.ami-0f2176987ee50226e In other regions, the ID is different"
    default = "ami-0aea13229426c207b"

}

variable "instance_type" {
    description = "AWS Instance type to be used for the WordPress instance"
    default = "t2.micro"
}



variable "volume_size" {
    description = "EBS volume size in GBs for the instance"
    default = 8
}

variable "key_name" {
    description = "The key pair that will be used to log to the server using SSH"
    default = "webtierkey"
}


variable "instance_count" {
  default = "2"
}

variable "project_name" {
  description = "The organization name provisioning the template (e.g. acme)"
  default     = "tata2019"
}

variable "char_delimiter" {
  description = "The delimiter to use for unique names (default: -)"
  default     = "-"
}

variable "repo_name" {
  description = "The name of the CodeCommit repository (e.g. new-repo)."
  default     = "test"
}

variable "repo_default_branch" {
  description = "The name of the default repository branch (default: master)"
  default     = "master"
}

variable "force_artifact_destroy" {
  description = "Force the removal of the artifact S3 bucket on destroy (default: false)."
  default     = "false"
}

variable "environment" {
  description = "The environment being deployed (default: dev)"
  default     = "dev"
}

variable "build_timeout" {
  description = "The time to wait for a CodeBuild to complete before timing out in minutes (default: 5)"
  default     = "5"
}

variable "build_compute_type" {
  description = "The build instance type for CodeBuild (default: BUILD_GENERAL1_SMALL)"
  default     = "BUILD_GENERAL1_SMALL"
}

variable "build_image" {
  description = "The build image for CodeBuild to use (default: aws/codebuild/amazonlinux2-x86_64-standard:1.0)"
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:1.0"
}

variable "build_privileged_override" {
  description = "Set the build privileged override to 'true' if you are not using a CodeBuild supported Docker base image. This is only relevant to building Docker images"
  default     = "false"
}

variable "test_buildspec" {
  description = "The buildspec to be used for the Test stage (default: buildspec_test.yml)"
  default     = "buildspec_test.yml"
}

variable "package_buildspec" {
  description = "The buildspec to be used for the Package stage (default: buildspec.yml)"
  default     = "buildspec.yml"
}

variable "name" {
  description = "Name of your codedeploy application"
  default = "code-deploy"
}

variable "project" {
  description = "The current project"
  default = "poc"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket where to fetch the application revision packages"
  default     = "arn:aws:s3:::tata2019-dev-test"
}


variable "bucket_name" {
    description = "this bucket will store the artificate"
    default = "tata2019-dev-test"
}


############################################################################################################

variable "service_role_arn" {
  description = "IAM role that is used by the deployment group"
  default = "arn:aws:iam::270357824811:role/poc-code-deploy"
}

variable "autoscaling_groups" {
  type        = list(string)
  description = "Autoscaling groups you want to attach to the deployment group"
   default =  ["tcl-autoscaling"]
}

variable "rollback_enabled" {
  description = "Whether to enable auto rollback"
  default     = false
}

variable "rollback_events" {
  description = "The event types that trigger a rollback"
  type        = list(string)
  default     = ["DEPLOYMENT_FAILURE"]
}
